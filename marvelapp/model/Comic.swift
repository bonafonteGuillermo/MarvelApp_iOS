import Foundation

struct Comic : Codable {
	let available : Int?
	let collectionURI : String?
	let items : [Item]?
	let returned : Int?
}
