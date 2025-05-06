// Copyright © 2025 IRFC

import Foundation

struct GalleryDTO: Codable, Identifiable {
    let id: Int
    let altText: String
    let path: String

    enum CodingKeys: String, CodingKey {
        case id = "galleryId"
        case altText
        case path
    }
}
