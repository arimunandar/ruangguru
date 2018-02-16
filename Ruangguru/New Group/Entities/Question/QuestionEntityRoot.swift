//
//  QuestionEntityRoot.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import SwiftyJSON

class QuestionEntityRoot: BaseEntity {
	
	var results: [QuestionEntity]?
	var response_code: Int?


	required init(json: JSON) {
		if let arr = json["results"].array {
			results = [QuestionEntity]()
			for subJSON in arr {
				results?.append(QuestionEntity(json: subJSON))
			}
		}
		response_code = json["response_code"].int
	}
}
