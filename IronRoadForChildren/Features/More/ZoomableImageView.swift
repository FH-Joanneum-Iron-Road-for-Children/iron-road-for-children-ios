import SwiftUI

struct ZoomableImageView: View {
	let imageURL: String
	let backgroundColor: Color
	@Binding var isZoomed: Bool

	var body: some View {
		GeometryReader { geometry in
			ZStack {
				backgroundColor

				AsyncImage(url: URL(string: imageURL)) { phase in
					switch phase {
					case .empty:
						ProgressView()
							.foregroundColor(.white)
					case let .success(image):
						image
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: geometry.size.width, height: geometry.size.height)
					case .failure:
						VStack {
							Image(systemName: "exclamationmark.triangle")
								.font(.largeTitle)
								.foregroundColor(.white)
							Text("Bild konnte nicht geladen werden")
								.foregroundColor(.white)
						}
					@unknown default:
						EmptyView()
					}
				}
			}
			.frame(width: geometry.size.width, height: geometry.size.height)
		}
	}
}
