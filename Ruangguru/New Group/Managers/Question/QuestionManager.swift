//
//  QuestionManager.swift
//  Ruangguru
//
//  Created by GREDU on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import RealmSwift

protocol IQuestionDataManager: class {
	func fetchQuestion(categoryId: Int, onSuccess: @escaping (Results<QuestionEntity>)->Void, onFail: (()->Void)?)
}

class QuestionDataManager: IQuestionDataManager {
	
	func fetchQuestion(categoryId: Int, onSuccess: @escaping (Results<QuestionEntity>) -> Void, onFail: (() -> Void)?) {
		
		RealmService.delete(object: QuestionEntity.self)
		
		let params: [String: Any] = [
			"amount": 20,
			"category": categoryId,
			"type": "multiple"
			] as [String: Any]
		
		BaseClient<QuestionEntityRoot>.fetchData(params, client: Clients.init(client: .question), onSuccess: { (questions) in
			questions.results?.forEach({ (question) in
				RealmService.save(object: question, update: false)
			})
			
			RealmService.fetch(object: QuestionEntity.self, completion: { (results) in
				onSuccess(results)
			})
		}) {
			onFail?()
		}
	}
}
