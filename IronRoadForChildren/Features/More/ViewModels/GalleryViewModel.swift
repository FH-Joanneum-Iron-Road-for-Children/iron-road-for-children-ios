import Foundation

class GalleryViewModel: ObservableObject {
	@Published var images: [GalleryDTO] = []
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil

	// Option 1: Zurück zur direkten URL (temporär)
	// private let apiUrl = "https://backend.irfc-test.fh-joanneum.at/api/gallery"

	private let apiPath = "/api/gallery"

	init() {
		// Configure URLCache with appropriate size
		let memoryCapacity = 10 * 1024 * 1024 // 10MB
		let diskCapacity = 50 * 1024 * 1024 // 50MB
		URLCache.shared = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity)
	}

	func loadImages(forceRefresh: Bool = false) {
		isLoading = true
		errorMessage = nil

		let worldUrl = world.serverUrlWith(path: apiPath)

		// Überprüfe, ob wir in der Test-Umgebung sind
		let url: URL
		if worldUrl.host?.contains("test") == true {
			// Wir sind bereits in der Test-Umgebung, verwende worldUrl
			url = worldUrl
		} else {
			// Wir sind nicht in der Test-Umgebung, verwende explizit die Test-URL
			url = URL(string: "https://backend.irfc-test.fh-joanneum.at/api/gallery")!
		}
		print("Fetching images from: \(url.absoluteString)")

		var request = URLRequest(url: url)
		request.httpMethod = "GET"
		request.addValue("application/json", forHTTPHeaderField: "Accept")

		// Set cache policy based on whether we're forcing a refresh
		request.cachePolicy = forceRefresh ? .reloadIgnoringLocalCacheData : .returnCacheDataElseLoad

		print("Fetching images from: \(url.absoluteString)")

		URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
			guard let self = self else { return }

			DispatchQueue.main.async {
				self.isLoading = false

				if let error = error {
					self.errorMessage = "Network error: \(error.localizedDescription)"
					print("Network error: \(error.localizedDescription)")
					return
				}

				// Überprüfe den HTTP-Statuscode
				if let httpResponse = response as? HTTPURLResponse {
					guard (200 ... 299).contains(httpResponse.statusCode) else {
						self.errorMessage = "Server error: \(httpResponse.statusCode)"
						print("Server error: \(httpResponse.statusCode)")
						return
					}
				}

				guard let data = data else {
					self.errorMessage = "No data received"
					print("No data received")
					return
				}

				// Debugging: Zeige die empfangenen JSON-Daten
				if let jsonString = String(data: data, encoding: .utf8) {
					print("Received JSON (first 200 chars): \(String(jsonString.prefix(200)))...")
				}

				do {
					// Dekodiere das JSON-Array in [GalleryDTO]
					let decoder = JSONDecoder()
					let galleryItems = try decoder.decode([GalleryDTO].self, from: data)
					print("Successfully decoded \(galleryItems.count) images")

					// Validiere URLs bevor du sie speicherst
					self.images = galleryItems.filter { image in
						guard let _ = URL(string: image.path) else {
							print("Invalid URL found: \(image.path)")
							return false
						}
						return true
					}

					if self.images.isEmpty, !galleryItems.isEmpty {
						self.errorMessage = "No valid image URLs found"
					}

					print("Processed \(self.images.count) images for display")
				} catch {
					self.errorMessage = "Failed to decode data: \(error.localizedDescription)"
					print("Decoding error: \(error)")

					// Ausführliche Debug-Information im Fehlerfall
					print("Detailed error: \(error)")

					// Zeige die vollständigen Daten für Debugging-Zwecke
					if let jsonString = String(data: data, encoding: .utf8) {
						print("Full received JSON: \(jsonString)")
					}
				}
			}
		}.resume()
	}

	// Hilfsmethode zum Neuladen der Daten
	func refreshData() {
		loadImages(forceRefresh: true)
	}

	// Hilfsmethode um ein einzelnes Bild anhand der ID zu finden
	func getImage(byId id: Int) -> GalleryDTO? {
		return images.first { $0.pictureId == id }
	}
}
