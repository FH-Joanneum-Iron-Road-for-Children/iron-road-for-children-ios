import Foundation

class GalleryViewModel: ObservableObject {
	@Published var images: [GalleryImage] = []
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil

	// API URL
	private let apiUrl = "https://picsum.photos/v2/list?page=1&limit=30"

	init() {
		// Configure URLCache with appropriate size
		let memoryCapacity = 10 * 1024 * 1024 // 10MB
		let diskCapacity = 50 * 1024 * 1024 // 50MB
		URLCache.shared = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity)
	}

	func loadImages(forceRefresh: Bool = false) {
		isLoading = true
		errorMessage = nil

		guard let url = URL(string: apiUrl) else {
			errorMessage = "Invalid URL"
			isLoading = false
			return
		}

		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.addValue("application/json", forHTTPHeaderField: "Accept")

		// Set cache policy based on whether we're forcing a refresh
		request.cachePolicy = forceRefresh ? .reloadIgnoringLocalCacheData : .returnCacheDataElseLoad

		print("Fetching images from: \(apiUrl)")

		URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
			guard let self = self else { return }

			DispatchQueue.main.async {
				self.isLoading = false

				if let error = error {
					self.errorMessage = "Network error: \(error.localizedDescription)"
					print("Network error: \(error.localizedDescription)")
					return
				}

				guard let data = data else {
					self.errorMessage = "No data received"
					print("No data received")
					return
				}

				do {
					// Decode as GalleryImage
					let dbImages = try JSONDecoder().decode([GalleryImage].self, from: data)
					print("Successfully decoded \(dbImages.count) images")

					// Validate URLs before saving
					self.images = dbImages.filter { image in
						guard let _ = URL(string: image.downloadURL) else {
							print("Invalid URL found: \(image.downloadURL)")
							return false
						}
						return true
					}

					if self.images.isEmpty && !dbImages.isEmpty {
						self.errorMessage = "No valid image URLs found"
					}

					print("Processed \(self.images.count) images for display")
				} catch {
					self.errorMessage = "Failed to decode data: \(error.localizedDescription)"
					print("Decoding error: \(error)")
				}
			}
		}.resume()
	}
}
