

import Foundation

struct ViewedMedia : Codable {
	let type : String?
	let subtype : String?
	let caption : String?
	let copyright : String?
	let approved_for_syndication : Int?
	let viewedMediaMetadatas : [ViewedMediaMetadata]?

	enum CodingKeys: String, CodingKey {

		case type = "type"
		case subtype = "subtype"
		case caption = "caption"
		case copyright = "copyright"
		case approved_for_syndication = "approved_for_syndication"
		case viewedMediaMetadatas = "media-metadata"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		subtype = try values.decodeIfPresent(String.self, forKey: .subtype)
		caption = try values.decodeIfPresent(String.self, forKey: .caption)
		copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
		approved_for_syndication = try values.decodeIfPresent(Int.self, forKey: .approved_for_syndication)
        viewedMediaMetadatas = try values.decodeIfPresent([ViewedMediaMetadata].self, forKey: .viewedMediaMetadatas)
	}

}
