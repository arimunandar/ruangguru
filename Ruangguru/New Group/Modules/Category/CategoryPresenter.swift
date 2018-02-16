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

protocol ICategoryPresenter: class {
	
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
}

extension CategoryPresenter: CategoryInteractorDelegate {
	
}
