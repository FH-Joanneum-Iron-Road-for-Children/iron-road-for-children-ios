// Copyright © 2025 IRFC

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
			.background(navbarBackgroundColor)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
		.background(navbarBackgroundColor)
		.edgesIgnoringSafeArea(.bottom)
	}
}

struct ZoomableImageView: View {
	let imageURL: String
	let backgroundColor: Color
	@Binding var isZoomed: Bool
	@State private var scale: CGFloat = 1.0
	@State private var lastScale: CGFloat = 1.0
	@State private var offset: CGSize = .zero
	@State private var lastOffset: CGSize = .zero
	@State private var imageLoaded = false

	var body: some View {
		GeometryReader { _ in
			ZStack {
				backgroundColor

				if !imageLoaded {
					ProgressView()
						.progressViewStyle(CircularProgressViewStyle())
						.foregroundColor(.white)
				}

				AsyncZoomableImage(url: URL(string: imageURL), isLoaded: $imageLoaded)
					.scaleEffect(scale)
					.offset(offset)
					.gesture(
						MagnificationGesture()
							.onChanged { value in
								let delta = value / lastScale
								lastScale = value
								scale = min(max(scale * delta, 1), 4)
								isZoomed = scale > 1.1
							}
							.onEnded { _ in
								lastScale = 1.0
								if scale < 1.1 {
									withAnimation {
										scale = 1.0
										offset = .zero
									}
									isZoomed = false
								}
							}
					)
					.simultaneousGesture(
						DragGesture()
							.onChanged { value in
								if scale > 1 {
									offset = CGSize(
										width: lastOffset.width + value.translation.width,
										height: lastOffset.height + value.translation.height
									)
								}
							}
							.onEnded { _ in
								lastOffset = offset
								if scale < 1.1 {
									withAnimation {
										offset = .zero
									}
								}
							}
					)
					.onTapGesture(count: 2) {
						withAnimation {
							if scale > 1 {
								scale = 1.0
								offset = .zero
								isZoomed = false
							} else {
								scale = min(2.0, 4.0)
								isZoomed = true
							}
						}
						lastOffset = offset
						lastScale = 1.0
					}
					.animation(.spring(), value: isZoomed)
			}
		}
	}
}

struct AsyncZoomableImage: View {
	let url: URL?
	@Binding var isLoaded: Bool
	@State private var image: UIImage? = nil

	var body: some View {
		Group {
			if let image = image {
				Image(uiImage: image)
					.resizable()
					.aspectRatio(contentMode: .fit)
			} else {
				Color.clear
			}
		}
		.onAppear {
			loadImage()
		}
	}

	private func loadImage() {
		guard let url = url else {
			isLoaded = false
			return
		}

		let task = URLSession.shared.dataTask(with: url) { data, _, error in
			guard let data = data, error == nil,
			      let loadedImage = UIImage(data: data)
			else {
				DispatchQueue.main.async {
					isLoaded = false
				}
				return
			}

			DispatchQueue.main.async {
				self.image = loadedImage
				isLoaded = true
			}
		}
		task.resume()
	}
}
