
import SwiftUI

struct GalleryView: View {
	@StateObject private var viewModel = GalleryViewModel()
	@State private var selectedImage: GalleryDTO?
	@State private var isDetailViewPresented = false
	@State private var lastViewedID: String? = nil

	// Define two columns with equal width
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
						// This is the key part - a proper LazyVGrid with correct spacing
						LazyVGrid(columns: columns, spacing: 10) {
							ForEach(viewModel.images) { image in
								// Use your existing GalleryImageView but with fixed dimensions
                                GalleryDTO(image: image)
									.id(image.id)
									// Don't set any additional frame here since your GalleryImageView
									// already sets its own frame constraints
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
		// Present the detail view as sheet
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
