import Foundation

class GalleryViewModel: ObservableObject {
	@Published var images: [GalleryImage] = []
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil

	// API URL
	private let apiUrl = "https://picsum.photos/v2/list?page=1&limit=30"

	func loadImages() {
		isLoading = true
		errorMessage = nil

		guard let url = URL(string: apiUrl) else {
			errorMessage = "Invalid URL"
			isLoading = false
			return
		}

		print("Fetching images from: \(apiUrl)")

		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.addValue("application/json", forHTTPHeaderField: "Accept")

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
					// Direkt als GalleryImage dekodieren
					let dbImages = try JSONDecoder().decode([GalleryImage].self, from: data)
					print("Successfully decoded \(dbImages.count) images")
					// Validiere URLs vor dem Speichern
					self.images = dbImages.filter { image in
						guard let _ = URL(string: image.download_url) else {
							print("Invalid URL found: \(image.download_url)")
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
