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
import Swinject

class CategoryAssembly: Assembly {
	
	func assemble(container: Container) {
		container.register(CategoryViewController.self) { r in
			let view = CategoryViewController()
			let presenter = r.resolve(ICategoryPresenter.self, argument: view as ICategoryViewController)!			
			view.presenter = presenter
			return view
		}
		
		container.register(ICategoryPresenter.self) { (r, view: ICategoryViewController) in
			let interactor = r.resolve(ICategoryInteractor.self)!
			let wireframe = r.resolve(ICategoryWireframe.self, argument: view as! CategoryViewController)!
			let presenter = CategoryPresenter(interactor: interactor, wireframe: wireframe, view: view)
			interactor.delegate = presenter
			return presenter
		}
		
		container.register(ICategoryInteractor.self) { r in
			let manager = r.resolve(ICategoryDataManager.self)!
			return CategoryInteractor(manager: manager)
		}
		
		container.register(ICategoryWireframe.self) { (r, view: CategoryViewController) in
			return CategoryWireframe(view: view)
		}
		
		container.register(ICategoryDataManager.self) { r in
			return CategoryDataManager()
		}
	}
}
