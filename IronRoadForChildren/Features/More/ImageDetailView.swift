import SwiftUI

struct ImageDetailView: View {
	let images: [GalleryImage]
	let selectedImage: GalleryImage
	@Binding var isPresented: Bool

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
						.padding()
				}

				Spacer()

				Text("Bild \(currentIndex + 1)")
					.bold()
					.padding()
			}
			.background(Color(UIColor.systemBackground))

			// Bilder im TabView
			TabView(selection: $currentIndex) {
				ForEach(0 ..< images.count, id: \.self) { index in
					BasicImageView(imageURL: images[index].download_url)
						.tag(index)
				}
			}
			.tabViewStyle(PageTabViewStyle())
			.background(Color.black)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
		.edgesIgnoringSafeArea(.bottom)
	}
}

// Eine extrem einfache View nur für das Bild
struct BasicImageView: View {
	let imageURL: String

	var body: some View {
		AsyncImage(url: URL(string: imageURL)) { phase in
			switch phase {
			case .empty:
				ProgressView()
			case let .success(image):
				image
					.resizable()
					.scaledToFit()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			case .failure:
				Image(systemName: "photo")
					.font(.largeTitle)
			@unknown default:
				EmptyView()
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.black)
	}
}
