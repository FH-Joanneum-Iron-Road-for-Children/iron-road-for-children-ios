
import Foundation

struct GalleryImage: Codable, Identifiable {
	let id: String
	let author: String
	let width: Int
	let height: Int
	let url: String
	let downloadURL: String

	var title: String? { return author }
}
