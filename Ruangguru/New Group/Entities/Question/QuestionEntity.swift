//
//  QuestionEntity.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import SwiftyJSON
import RealmSwift

class QuestionEntity: Object {
	
	@objc dynamic var category: String?
	@objc dynamic var correct_answer: String?
	@objc dynamic var difficulty: String?
	@objc dynamic var question: String?
	@objc dynamic var type: String?
	var incorrect_answers = List<String>()

	required convenience public init(json: JSON) {
		self.init()
		
		category = json["category"].string
		correct_answer = json["correct_answer"].string
		difficulty = json["difficulty"].string
		question = json["question"].string
		type = json["type"].string
		if let arr = json["incorrect_answers"].array{
			incorrect_answers = List<String>()
			for subJSON in arr {
				incorrect_answers.append(String(describing: subJSON))
			}
		}
	}
}
