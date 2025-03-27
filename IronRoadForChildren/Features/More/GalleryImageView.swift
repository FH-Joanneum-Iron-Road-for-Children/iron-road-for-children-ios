import SwiftUI

struct GalleryImageView: View {
	let image: GalleryImage

	var body: some View {
		GeometryReader { geometry in
			AsyncImage(url: URL(string: image.download_url)) { phase in
				switch phase {
				case .empty:
					ProgressView()
				case let .success(loadedImage):
					loadedImage
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(width: geometry.size.width, height: geometry.size.height)
						.clipped()
				case .failure:
					Image(systemName: "photo")
						.imageScale(.large)
						.foregroundColor(.gray)
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.background(Color.gray.opacity(0.2))
				@unknown default:
					Image(systemName: "photo")
						.imageScale(.large)
						.foregroundColor(.gray)
				}
			}
		}
	}
}
