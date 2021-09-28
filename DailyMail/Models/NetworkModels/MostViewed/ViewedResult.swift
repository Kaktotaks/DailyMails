

import Foundation

struct ViewedResult : Codable {
	let status : String?
	let copyright : String?
	let num_results : Int?
	let vieweds : [Viewed]?

	enum CodingKeys: String, CodingKey {

		case status = "status"
		case copyright = "copyright"
		case num_results = "num_results"
		case vieweds = "results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
		num_results = try values.decodeIfPresent(Int.self, forKey: .num_results)
        vieweds = try values.decodeIfPresent([Viewed].self, forKey: .vieweds)
	}

}
