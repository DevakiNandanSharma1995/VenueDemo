
import Foundation
struct VenueListModel : Codable {
	let venues : [Venues]?
	let meta : Meta?

	enum CodingKeys: String, CodingKey {

		case venues = "venues"
		case meta = "meta"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		venues = try values.decodeIfPresent([Venues].self, forKey: .venues)
		meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
	}

}
