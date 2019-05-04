import Foundation

struct Data : Codable {
	let offset : Int?
	let limit : Int?
	let total : Int?
	let count : Int?
	let results : [Character]?
}
