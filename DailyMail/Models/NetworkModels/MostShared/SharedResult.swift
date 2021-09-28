

import Foundation

struct SharedResult : Codable {
	let status : String?
	let copyright : String?
	let num_results : Int?
	let shareds : [Shared]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case copyright = "copyright"
		case num_results = "num_results"
		case shareds = "results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
		num_results = try values.decodeIfPresent(Int.self, forKey: .num_results)
        shareds = try values.decodeIfPresent([Shared].self, forKey: .shareds)
	}

}
