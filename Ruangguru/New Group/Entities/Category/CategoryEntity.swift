//
//  CategoryEntity.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import SwiftyJSON
import RealmSwift

class CategoryEntity: Object {
	
	@objc dynamic var id: Int = 0
	@objc dynamic var name: String?

	required convenience public init(json: JSON) {
		self.init()
		id = json["id"].int ?? 0
		name = json["name"].string
	}
	
	override static func primaryKey() -> String? {
		return "id"
	}
}
