//
//  QuestionInteractor.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit
import RealmSwift

protocol QuestionInteractorDelegate: class {
	func didSuccessFetchQuestion(data: Results<QuestionEntity>)
	func didFailureFetchQuestion()
}

protocol IQuestionInteractor: class {
	var delegate: QuestionInteractorDelegate? { get set }
	func fetchQuestionData(categoryId: Int)
}

class QuestionInteractor: IQuestionInteractor {
	
	var manager: IQuestionDataManager?
	var delegate: QuestionInteractorDelegate?
	
	init(manager: IQuestionDataManager) {
		self.manager = manager
	}
	
	func fetchQuestionData(categoryId: Int) {
		self.manager?.fetchQuestion(categoryId: categoryId, onSuccess: { (questions) in
			self.delegate?.didSuccessFetchQuestion(data: questions)
		}, onFail: {
			self.delegate?.didFailureFetchQuestion()
		})
	}
}
