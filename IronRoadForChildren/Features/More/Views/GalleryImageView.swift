import SwiftUI

struct GalleryImageView: View {
    let image: GalleryDTO
    @State private var imageLoaded = false
    @State private var loadingError = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // Placeholder while loading
                Rectangle()
                    .fill(Color.gray.opacity(0.1))
                    .aspectRatio(1.0, contentMode: .fill) // Square aspect ratio
                    .cornerRadius(12)
                
                // Loading indicator
                if !imageLoaded && !loadingError {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
                
                // Error indicator
                if loadingError {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.gray)
                        .font(.largeTitle)
                }
                
                // Actual image
                if let url = URL(string: image.path) {
                    AsyncImageView(url: url, onLoaded: { success in
                        imageLoaded = success
                        loadingError = !success
                    })
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .aspectRatio(1.0, contentMode: .fill) // Square aspect ratio
                    .cornerRadius(12)
                    .clipped()
                }
                
                // Title overlay - improved with better gradient and positioning
                VStack(alignment: .leading) {
                    Spacer()
                    
                    HStack {
                        Text(image.altText)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 10)
                        
                        Spacer()
                    }
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, Color.black.opacity(0.7)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                }
                .cornerRadius(12)
            }
            .aspectRatio(1.0, contentMode: .fit) // Ensure the container is also square
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.vertical, 6) // Add vertical padding to separate rows
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1) // Subtle shadow
    }
}

// Custom AsyncImage implementation
struct AsyncImageView: View {
    let url: URL
    let onLoaded: (Bool) -> Void
    @State private var image: UIImage? = nil
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
            } else {
                Color.clear
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        // Check cache first
        if let cachedData = URLCache.shared.cachedResponse(for: URLRequest(url: url))?.data,
           let cachedImage = UIImage(data: cachedData) {
            DispatchQueue.main.async {
                self.image = cachedImage
                onLoaded(true)
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil,
                  let loadedImage = UIImage(data: data) else {
                DispatchQueue.main.async {
                    onLoaded(false)
                }
                return
            }
            
            DispatchQueue.main.async {
                self.image = loadedImage
                onLoaded(true)
            }
        }
        task.resume()
    }
}
