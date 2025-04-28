import Foundation

struct GalleryDTO: Codable, Identifiable {
    // Changed to optional Int with a default value
    let pictureId: Int?
    let altText: String
    let path: String
    
    // UUID to ensure uniqueness even when pictureId is null
    private let uuid = UUID()
    
    // Identifiable with a unique ID
    var id: String {
        // If pictureId exists, use it; otherwise use the uuid string
        if let id = pictureId {
            return String(id)
        } else {
            return uuid.uuidString
        }
    }
    
    var imageURK: URL? {
        return URL(string: path)
    }
    
    var title: String {
        return altText
    }
    
    enum CodingKeys: String, CodingKey {
        case pictureId = "pictureId"
        case altText = "altText"
        case path = "path"
    }
}
