
import SwiftUI

struct ImageDetailView: View {
	let images: [GalleryDTO]
	let selectedImage: GalleryDTO
	@Binding var isPresented: Bool
	let navbarBackgroundColor = Color("irfcBlue")
	@State private var currentIndex: Int
	@State private var isZoomed: Bool = false

	init(images: [GalleryDTO], selectedImage: GalleryDTO, isPresented: Binding<Bool>) {
		self.images = images
		self.selectedImage = selectedImage
		_isPresented = isPresented
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

				Text("#IRFC25")
					.foregroundColor(.white)
					.bold()
					.padding()
			}
			.background(navbarBackgroundColor)

			TabView(selection: $currentIndex) {
				ForEach(0 ..< images.count, id: \.self) { index in
					ZoomableImageView(
                        imageURL: images[index].path,
						backgroundColor: navbarBackgroundColor,
						isZoomed: $isZoomed
					)
					.tag(index)
				}
			}
			.tabViewStyle(PageTabViewStyle())
			.indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
			// .disabled(isZoomed)
			.background(navbarBackgroundColor)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
		.background(navbarBackgroundColor)
		.edgesIgnoringSafeArea(.bottom)
	}
}
