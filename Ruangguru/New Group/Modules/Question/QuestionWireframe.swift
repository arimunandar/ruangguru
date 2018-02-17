//
//  QuestionWireframe.swift
//  Ruangguru
//
//  Created by GREDU on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

protocol IQuestionWireframe: class {
	func dismissView()
}

class QuestionWireframe: IQuestionWireframe {
	
	weak var view: QuestionViewController?
	
	init(view: QuestionViewController) {
		self.view = view
	}
	
	func dismissView() {
		self.view?.navigationController?.isNavigationBarHidden = false
		self.view?.navigationController?.popViewController(animated: true)
	}
}
