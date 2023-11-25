
import Foundation
struct Stats : Codable {
	let event_count : Int?

	enum CodingKeys: String, CodingKey {

		case event_count = "event_count"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		event_count = try values.decodeIfPresent(Int.self, forKey: .event_count)
	}

}
