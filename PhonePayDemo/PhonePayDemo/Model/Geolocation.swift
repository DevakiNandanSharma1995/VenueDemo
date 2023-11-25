import Foundation
struct Geolocation : Codable {
	let lat : Double?
	let lon : Double?
	let city : String?
	let state : String?
	let country : String?
	let postal_code : String?
	let display_name : String?
	let metro_code : String?
	let range : String?

	enum CodingKeys: String, CodingKey {

		case lat = "lat"
		case lon = "lon"
		case city = "city"
		case state = "state"
		case country = "country"
		case postal_code = "postal_code"
		case display_name = "display_name"
		case metro_code = "metro_code"
		case range = "range"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		lat = try values.decodeIfPresent(Double.self, forKey: .lat)
		lon = try values.decodeIfPresent(Double.self, forKey: .lon)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		state = try values.decodeIfPresent(String.self, forKey: .state)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		postal_code = try values.decodeIfPresent(String.self, forKey: .postal_code)
		display_name = try values.decodeIfPresent(String.self, forKey: .display_name)
		metro_code = try values.decodeIfPresent(String.self, forKey: .metro_code)
		range = try values.decodeIfPresent(String.self, forKey: .range)
	}

}
