import SwiftUI

struct GalleryView: View {
	@StateObject private var viewModel = GalleryViewModel()
	@State private var selectedImage: GalleryDTO?
	@State private var isDetailViewPresented = false
	@State private var lastViewedID: Int? = nil

	private let columns = [
		GridItem(.flexible(), spacing: 12),
		GridItem(.flexible(), spacing: 12),
	]

	var body: some View {
		ScrollViewReader { proxy in
			ZStack {
				Color(UIColor.systemBackground)
					.edgesIgnoringSafeArea(.all)

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
				} else if viewModel.items.isEmpty {
					Text("No images found")
				} else {
					ScrollView {
						LazyVGrid(columns: columns, spacing: 12) {
							ForEach(viewModel.items, id: \.id) { image in
								GalleryImageView(image: image)
									.id(image.id)
									.onTapGesture {
										selectedImage = image
										lastViewedID = image.id
										isDetailViewPresented = true
									}
							}
						}
						.padding(.horizontal, 16)
						.padding(.top, 12)
						.padding(.bottom, 80)
					}
					.refreshable {
						viewModel.loadImages()
					}
				}
			}
			.navigationTitle("Galerie")
			.onAppear {
				if viewModel.items.isEmpty && !viewModel.isLoading {
					viewModel.loadImages()
				}

				if let lastID = lastViewedID, !viewModel.items.isEmpty {
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
						withAnimation {
							proxy.scrollTo(lastID, anchor: .top)
						}
					}
				}
			}
			.sheet(isPresented: $isDetailViewPresented) {
				if let selectedImage = selectedImage {
					ImageDetailView(
						images: viewModel.items,
						selectedImage: selectedImage,
						isPresented: $isDetailViewPresented
					)
				}
			}
		}
	}
}
