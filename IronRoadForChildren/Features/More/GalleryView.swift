import SwiftUI

struct GalleryView: View {
	@StateObject private var viewModel = GalleryViewModel()
	@State private var selectedImage: GalleryImage?
	@State private var isDetailViewPresented = false
	@State private var lastViewedID: String? = nil

	private let columns = [
		GridItem(.flexible(), spacing: 10),
		GridItem(.flexible(), spacing: 10),
	]

	var body: some View {
		ScrollViewReader { proxy in
			ZStack {
				if viewModel.isLoading {
					ProgressView("Loading gallery...")
				} else if let errorMessage = viewModel.errorMessage {
					VStack {
						Text(errorMessage)
							.foregroundColor(.red)
						Button("Try Again") {
							viewModel.loadImages()
						}
						.padding()
						.background(Color.blue)
						.foregroundColor(.white)
						.cornerRadius(8)
					}
				} else if viewModel.images.isEmpty {
					Text("No images found")
				} else {
					ScrollView {
						LazyVGrid(columns: columns, spacing: 10) {
							ForEach(viewModel.images) { image in
								GalleryImageView(image: image)
									.id(image.id)
									.frame(height: 150)
									.cornerRadius(15)
									.onTapGesture {
										selectedImage = image
										lastViewedID = image.id
										isDetailViewPresented = true
									}
							}
						}
						.padding(10)
					}
					.refreshable {
						viewModel.loadImages()
					}
				}
			}
			.navigationTitle("Galerie")
			.onAppear {
				// Only load images if we haven't already
				if viewModel.images.isEmpty && !viewModel.isLoading {
					viewModel.loadImages()
				}

				// Scroll to previously viewed image if we have one
				if let lastID = lastViewedID, !viewModel.images.isEmpty {
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
						withAnimation {
							proxy.scrollTo(lastID, anchor: .top)
						}
					}
				}
			}
		}
		// Präsentiere die Detail-Ansicht als Sheet
		.sheet(isPresented: $isDetailViewPresented) {
			if let selectedImage = selectedImage {
				ImageDetailView(
					images: viewModel.images,
					selectedImage: selectedImage,
					isPresented: $isDetailViewPresented
				)
			}
		}
	}
}
