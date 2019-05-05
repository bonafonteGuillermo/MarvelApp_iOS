import Foundation

struct Storie : Codable {
	let available : Int?
	let collectionURI : String?
	let items : [Item]?
	let returned : Int?
}
