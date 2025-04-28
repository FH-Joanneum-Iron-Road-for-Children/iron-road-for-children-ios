
import Foundation

struct GalleryDTO: Codable, Identifiable {
    let pictureId: Int
	let altText: String
    let path: String
    
    //Identifiable mit eindeutigen ID
    var id: Int {
        return pictureId
    }
    
    var imageURK: URL {
        return URL(string: path)!
    }
    
    var title: String {
        return altText
    }
    
    enum CodingKeyx: String, CodingKey {
        case pictureId = "pictureId"
        case altText = "altText"
        case path = "path"
    }
}
