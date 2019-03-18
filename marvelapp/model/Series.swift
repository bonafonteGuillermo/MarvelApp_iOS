import Foundation

struct Series : Codable {
	let available : Int?
	let collectionURI : String?
	let items : [Items]?
	let returned : Int?
}
