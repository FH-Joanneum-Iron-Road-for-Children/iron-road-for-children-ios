import SwiftUI

// ZoomableImageView mit angepasstem Hintergrund
struct ZoomableImageView: View {
	let imageURL: String
	let backgroundColor: Color

	@State private var scale: CGFloat = 1.0
	@State private var lastScale: CGFloat = 1.0
	@State private var offset: CGSize = .zero
	@State private var lastOffset: CGSize = .zero

	var body: some View {
		GeometryReader { geometry in
			AsyncImage(url: URL(string: imageURL)) { phase in
				switch phase {
				case .empty:
					ProgressView()
						.foregroundColor(.white)
						.frame(width: geometry.size.width, height: geometry.size.height)
				case let .success(image):
					image
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: geometry.size.width, height: geometry.size.height)
						.scaleEffect(scale)
						.offset(offset)
						.contentShape(Rectangle())
						.gesture(
							MagnificationGesture()
								.onChanged { value in
									let delta = value / lastScale
									lastScale = value

									// Begrenze die Skalierung
									let newScale = scale * delta
									scale = min(max(newScale, 1.0), 5.0)
								}
								.onEnded { _ in
									lastScale = 1.0
								}
						)
						.gesture(
							DragGesture()
								.onChanged { value in
									// Nur Verschieben erlauben wenn gezoomt
									if scale > 1.0 {
										offset = CGSize(
											width: lastOffset.width + value.translation.width,
											height: lastOffset.height + value.translation.height
										)
									}
								}
								.onEnded { _ in
									lastOffset = offset
								}
						)
						.onTapGesture(count: 2) {
							// Bei Doppeltipp zurücksetzen
							withAnimation {
								scale = 1.0
								offset = .zero
								lastOffset = .zero
							}
						}
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
			.frame(width: geometry.size.width, height: geometry.size.height)
			.contentShape(Rectangle())
		}
		.background(backgroundColor)
	}
}
