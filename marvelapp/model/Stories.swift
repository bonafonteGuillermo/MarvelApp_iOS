import Foundation

struct Stories : Codable {
	let available : Int?
	let collectionURI : String?
	let items : [Items]?
	let returned : Int?
}
