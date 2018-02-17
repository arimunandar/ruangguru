//
//  QuestionPresenter.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit
import RealmSwift

protocol IQuestionPresenter: class {
	var parameters: [String: Any]? { get set }
	
	func handleFetchQuestion(categoryId: Int)
	func handleStarOver()
}

class QuestionPresenter: IQuestionPresenter {
	
	var interactor: IQuestionInteractor?
	var wireframe: IQuestionWireframe?
	weak var view: IQuestionViewController?
	var parameters: [String: Any]?
	
	init(interactor: IQuestionInteractor, wireframe: IQuestionWireframe, view: IQuestionViewController) {
		self.interactor = interactor
		self.wireframe = wireframe
		self.view = view
	}
	
	func handleFetchQuestion(categoryId: Int) {
		self.interactor?.fetchQuestionData(categoryId: categoryId)
	}
	
	func handleStarOver() {
		self.wireframe?.dismissView()
	}
}

extension QuestionPresenter: QuestionInteractorDelegate {
	
	func didSuccessFetchQuestion(data: Results<QuestionEntity>) {
		self.view?.displayQuestionData(data: data)
	}
	
	func didFailureFetchQuestion() {
		self.wireframe?.dismissView()
	}
}
