//
//  EmailedRealm.swift
//  DailyMail
//
//  Created by Леонід Шевченко on 01.10.2021.
//

import Foundation
import RealmSwift

class EmailedRealm: Object {
    @objc dynamic var uri: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var asset_id: Int = 0
    @objc dynamic var source: String = ""
    @objc dynamic var published_date: String = ""
    @objc dynamic var updated: String = ""
    @objc dynamic var section: String = ""
    @objc dynamic var subsection: String = ""
    @objc dynamic var nytdsection: String = ""
    @objc dynamic var adx_keywords: String = ""
    @objc dynamic var column: String = ""
    @objc dynamic var byline: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var abstract: String = ""
    @objc dynamic var eta_id: Int = 0
}
