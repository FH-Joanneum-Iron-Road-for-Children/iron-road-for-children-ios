import SwiftUI

struct ZoomableImageView: View {
	let image: GalleryImage

	@State private var scale: CGFloat = 1.0
	@State private var lastScale: CGFloat = 1.0
	@State private var offset: CGSize = .zero
	@State private var lastOffset: CGSize = .zero

	var body: some View {
		// Zoombare Bildansicht ohne Autor-Text
		GeometryReader { geometry in
			AsyncImage(url: URL(string: image.download_url)) { phase in
				switch phase {
				case .empty:
					ProgressView()
						.frame(width: geometry.size.width, height: geometry.size.height)
				case let .success(loadedImage):
					loadedImage
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: geometry.size.width, height: geometry.size.height)
						.scaleEffect(scale)
						.offset(offset)
						.contentShape(Rectangle()) // Macht die gesamte Fläche für Gesten verfügbar
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
							.foregroundColor(.red)
						Text("Bild konnte nicht geladen werden")
					}
					.frame(width: geometry.size.width, height: geometry.size.height)
				@unknown default:
					Text("Unbekannter Status")
				}
			}
		}
		.contentShape(Rectangle()) // Wichtig: Macht die gesamte Fläche für Gesten verfügbar
	}
}

// Hilfserweiterung für sichere Array-Indizierung
extension Array {
	subscript(safe index: Index) -> Element? {
		return indices.contains(index) ? self[index] : nil
	}
}
