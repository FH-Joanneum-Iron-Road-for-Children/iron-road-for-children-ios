
import SwiftUI

struct ImageDetailView: View {
	let images: [GalleryImage]
	let selectedImage: GalleryImage
	@Binding var isPresented: Bool

	// Die Farbe der unteren Navigationsleiste
	let navbarBackgroundColor = Color(red: 0.16, green: 0.18, blue: 0.31)

	@State private var currentIndex: Int

	// Initialisierung des aktuellen Index im Konstruktor
	init(images: [GalleryImage], selectedImage: GalleryImage, isPresented: Binding<Bool>) {
		self.images = images
		self.selectedImage = selectedImage
		_isPresented = isPresented

		// Finde den Index des ausgewählten Bildes
		let initialIndex = images.firstIndex(where: { $0.id == selectedImage.id }) ?? 0
		_currentIndex = State(initialValue: initialIndex)
	}

	var body: some View {
		VStack(spacing: 0) {
			// Header mit Zurück-Button
			HStack {
				Button {
					isPresented = false
				} label: {
					Text("Zurück")
						.foregroundColor(.white)
						.padding()
				}

				Spacer()

				Text("IRFC25")
					.foregroundColor(.white)
					.bold()
					.padding()
			}
			.background(navbarBackgroundColor)

			// Bilder im TabView mit dem gleichen Hintergrund wie die Navigationsleiste
			TabView(selection: $currentIndex) {
				ForEach(0 ..< images.count, id: \.self) { index in
					ZoomableImageView(
						imageURL: images[index].download_url,
						backgroundColor: navbarBackgroundColor
					)
					.tag(index)
					.contentShape(Rectangle())
				}
			}
			.tabViewStyle(PageTabViewStyle())
			.background(navbarBackgroundColor)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.contentShape(Rectangle())
		}
		.background(navbarBackgroundColor)
		.edgesIgnoringSafeArea(.bottom)
	}
}
