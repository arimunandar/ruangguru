//
//  RealmService.swift
//  Ruangguru
//
//  Created by GREDU on 2/16/18.
//  Copyright © 2018 Ari Munandar. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
	
	class func fetch<Element: Object>(object: Element.Type, completion: (Results<Element>)->Void) {
		let realm = try! Realm()
		let results = realm.objects(Element.self)
		completion(results)
	}
	
	class func save<Element: Object>(object: Element, update: Bool = true) {
		let realm = try! Realm()
		try! realm.write {
			if update {
				realm.add(object.self, update: true)
			} else {
				realm.add(object.self)
			}
		}
	}
	
	class func delete<Element: Object>(object: Element.Type) {
		let realm = try! Realm()
		let data = realm.objects(object.self)
		try! realm.write {
			realm.delete(data)
		}
	}
}
