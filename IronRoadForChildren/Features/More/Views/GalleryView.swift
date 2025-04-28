import SwiftUI

struct GalleryView: View {
    @StateObject private var viewModel = GalleryViewModel()
    @State private var selectedImage: GalleryDTO?
    @State private var isDetailViewPresented = false
    @State private var lastViewedID: String? = nil
    
    // Grid with more appropriate spacing
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        ScrollViewReader { proxy in
            ZStack {
                // Background color
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
                } else if viewModel.images.isEmpty {
                    Text("No images found")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(viewModel.images, id: \.id) { image in
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
                        // Added proper padding at the bottom to avoid tab bar overlap
                        .padding(.bottom, 80)
                    }
                    .refreshable {
                        viewModel.refreshData()
                    }
                }
            }
            .navigationTitle("Galerie")
            .onAppear {
                if viewModel.images.isEmpty && !viewModel.isLoading {
                    viewModel.loadImages()
                }
                
                if let lastID = lastViewedID, !viewModel.images.isEmpty {
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
                        images: viewModel.images,
                        selectedImage: selectedImage,
                        isPresented: $isDetailViewPresented
                    )
                }
            }
        }
    }
}
