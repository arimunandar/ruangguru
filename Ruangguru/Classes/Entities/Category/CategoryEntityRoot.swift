//
//  CategoryAssembly.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import SwiftyJSON

class CategoryEntityRoot: BaseEntity {
	
	var trivia_categories: [CategoryEntity]?

	required init(json: JSON) {
		if let arr = json["trivia_categories"].array {
			trivia_categories = [CategoryEntity]()
			for subJSON in arr {
				trivia_categories?.append(CategoryEntity(json: subJSON))
			}
		}
	}
}
