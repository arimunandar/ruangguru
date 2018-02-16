//
//  CategoryWireframe.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

protocol ICategoryWireframe: class {
	func navigateToQuestionPage(data: [String: Any])
}

class CategoryWireframe: ICategoryWireframe {
	
	weak var view: CategoryViewController?
	
	init(view: CategoryViewController) {
		self.view = view
	}
	
	func navigateToQuestionPage(data: [String : Any]) {
		let question = AppRouter.present().resolve(QuestionViewController.self, argument: data)
		self.view?.navigationController?.pushViewController(question!, animated: true)
	}
}
