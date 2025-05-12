// Copyright © 2025 IRFC

import Foundation
import SwiftUI

@MainActor
class GalleryViewModel: ObservableObject {
    @Published var items: [GalleryDTO] = []
    @Published var isLoading: Bool = false
    @Published var selected: GalleryDTO?
    @Published var errorMessage: String?

    init() {
        let memoryCapacity = 10 * 1024 * 1024 // 10MB
        let diskCapacity = 50 * 1024 * 1024 // 50MB
        URLCache.shared = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity)
    }

    func loadImages() {
        Task { @MainActor in
            isLoading = true
            defer { isLoading = false }
            let url = world.serverUrlWith(path: "/api/gallery")
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let http = response as? HTTPURLResponse,
                      (200..<300).contains(http.statusCode) else {
                    errorMessage = "HTTP \( (response as? HTTPURLResponse)?.statusCode ?? -1 )"
                    return
                }
                let decoded = try JSONDecoder().decode([GalleryDTO].self, from: data)
                items = decoded
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
