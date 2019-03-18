import Foundation

struct Thumbnail : Codable {
	let path : String?
	let thumbnailExtension : String?

	enum CodingKeys: String, CodingKey {

		case path = "path"
		case thumbnailExtension = "extension"
	}
}
