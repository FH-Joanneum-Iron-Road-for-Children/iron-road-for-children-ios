import SwiftUI

struct GalleryImageView: View {
	let image: GalleryImage
	@State private var downloadedImage: UIImage?
	@State private var isLoading = false

	var body: some View {
		ZStack {
			if let downloadedImage = downloadedImage {
				Image(uiImage: downloadedImage)
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
					.clipped()
			} else {
				Color.gray.opacity(0.2)

				if isLoading {
					ProgressView()
				} else {
					Image(systemName: "photo")
						.font(.largeTitle)
						.foregroundColor(.gray)
				}
			}
		}
		.frame(minWidth: 0, maxWidth: .infinity, minHeight: 150, maxHeight: 150)
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.onAppear {
			loadImage()
		}
	}

	private func loadImage() {
		guard let url = URL(string: image.downloadURL) else { return }

		// Check cache first
		let cacheKey = NSString(string: url.absoluteString)
		if let cachedImage = ImageCache.shared.getImage(for: cacheKey) {
			downloadedImage = cachedImage
			return
		}

		// If not in cache, download it
		isLoading = true

		// Create a cached URL request
		var request = URLRequest(url: url)
		request.cachePolicy = .returnCacheDataElseLoad

		URLSession.shared.dataTask(with: request) { data, _, error in
			DispatchQueue.main.async {
				isLoading = false

				guard let data = data, error == nil,
				      let downloaded = UIImage(data: data)
				else {
					return
				}

				// Cache the downloaded image
				ImageCache.shared.setImage(downloaded, for: cacheKey)
				self.downloadedImage = downloaded
			}
		}.resume()
	}
}
