

import Foundation

struct Emailed : Codable {
	let uri : String?
	let url : String?
	let id : Int?
	let asset_id : Int?
	let source : String?
	let published_date : String?
	let updated : String?
	let section : String?
	let subsection : String?
	let nytdsection : String?
    let adx_keywords : String?
	let column : String?
	let byline : String?
	let type : String?
	let title : String?
	let abstract : String?
	let eta_id : Int?

	enum CodingKeys: String, CodingKey {

		case uri = "uri"
		case url = "url"
		case id = "id"
		case asset_id = "asset_id"
		case source = "source"
		case published_date = "published_date"
		case updated = "updated"
		case section = "section"
		case subsection = "subsection"
		case nytdsection = "nytdsection"
        case adx_keywords = "adx_keywords"
		case column = "column"
		case byline = "byline"
		case type = "type"
		case title = "title"
		case abstract = "abstract"
		case eta_id = "eta_id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		uri = try values.decodeIfPresent(String.self, forKey: .uri)
		url = try values.decodeIfPresent(String.self, forKey: .url)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		asset_id = try values.decodeIfPresent(Int.self, forKey: .asset_id)
		source = try values.decodeIfPresent(String.self, forKey: .source)
		published_date = try values.decodeIfPresent(String.self, forKey: .published_date)
		updated = try values.decodeIfPresent(String.self, forKey: .updated)
		section = try values.decodeIfPresent(String.self, forKey: .section)
		subsection = try values.decodeIfPresent(String.self, forKey: .subsection)
		nytdsection = try values.decodeIfPresent(String.self, forKey: .nytdsection)
        adx_keywords = try values.decodeIfPresent(String.self, forKey: .adx_keywords)
		column = try values.decodeIfPresent(String.self, forKey: .column)
		byline = try values.decodeIfPresent(String.self, forKey: .byline)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		abstract = try values.decodeIfPresent(String.self, forKey: .abstract)
		eta_id = try values.decodeIfPresent(Int.self, forKey: .eta_id)
	}
    
    
    init(from mediaRealm: MediaRealm) {
        self.uri = mediaRealm.uri
        self.url = mediaRealm.url
        self.id = mediaRealm.id
        self.asset_id = mediaRealm.asset_id
        self.subsection = mediaRealm.subsection
        self.nytdsection = mediaRealm.nytdsection
        self.adx_keywords = mediaRealm.adx_keywords
        self.column = mediaRealm.column
        self.type = mediaRealm.type
        self.eta_id = mediaRealm.eta_id
        self.source = mediaRealm.source
        self.published_date = mediaRealm.published_date
        self.updated = mediaRealm.updated
        self.section = mediaRealm.section
        self.byline = mediaRealm.byline
        self.title = mediaRealm.title
        self.abstract = mediaRealm.abstract
    }

}
