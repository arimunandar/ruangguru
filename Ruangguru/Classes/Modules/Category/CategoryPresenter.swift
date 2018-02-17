//
//  CategoryPresenter.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit
import RealmSwift

protocol ICategoryPresenter: class {
	func handleFetchCategory()
	func navigateToQuestionPage(data: [String: Any])
}

class CategoryPresenter: ICategoryPresenter {
	
	var interactor: ICategoryInteractor?
	var wireframe: ICategoryWireframe?
	weak var view: ICategoryViewController?
	
	init(interactor: ICategoryInteractor, wireframe: ICategoryWireframe, view: ICategoryViewController) {
		self.interactor = interactor
		self.wireframe = wireframe
		self.view = view
	}
	
	func handleFetchCategory() {
		self.interactor?.fetchCategoryData()
	}
	
	func navigateToQuestionPage(data: [String : Any]) {
		self.wireframe?.navigateToQuestionPage(data: data)
	}
}

extension CategoryPresenter: CategoryInteractorDelegate {
	
	func didSuccessFetchCategory(data: Results<CategoryEntity>) {
		self.view?.displayData(data: data)
	}
}
