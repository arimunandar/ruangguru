//
//  QuestionAssembly.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import Swinject

class QuestionAssembly: Assembly {
	
	func assemble(container: Container) {
		container.register(QuestionViewController.self) { (r, parameters: [String: Any]) in
			let view = QuestionViewController()
			let presenter = r.resolve(IQuestionPresenter.self, argument: view as IQuestionViewController)!
			presenter.parameters = parameters
			view.presenter = presenter
			return view
		}
		
		container.register(IQuestionPresenter.self) { (r, view: IQuestionViewController) in
			let interactor = r.resolve(IQuestionInteractor.self)!
			let wireframe = r.resolve(IQuestionWireframe.self, argument: view as! QuestionViewController)!
			let presenter = QuestionPresenter(interactor: interactor, wireframe: wireframe, view: view)
			interactor.delegate = presenter
			return presenter
		}
		
		container.register(IQuestionInteractor.self) { r in
			let manager = r.resolve(IQuestionDataManager.self)!
			return QuestionInteractor(manager: manager)
		}
		
		container.register(IQuestionWireframe.self) { (r, view: QuestionViewController) in
			return QuestionWireframe(view: view)
		}
		
		container.register(IQuestionDataManager.self) { r in
			return QuestionDataManager()
		}
	}
}
