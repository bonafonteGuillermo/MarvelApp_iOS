import Foundation

struct Results : Codable {
	let id : Int?
	let name : String?
	let description : String?
	let modified : String?
	let thumbnail : Thumbnail?
	let resourceURI : String?
	let comics : Comics?
	let series : Series?
	let stories : Stories?
	let events : Events?
	let urls : [Urls]?
}
