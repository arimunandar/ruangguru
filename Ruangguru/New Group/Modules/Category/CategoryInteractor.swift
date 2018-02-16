//
//  CategoryInteractor.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

protocol CategoryInteractorDelegate: class {
	
}

protocol ICategoryInteractor: class {
	var delegate: CategoryInteractorDelegate? { get set }
}

class CategoryInteractor: ICategoryInteractor {
	
	var manager: ICategoryDataManager?
	var delegate: CategoryInteractorDelegate?
	
	init(manager: ICategoryDataManager) {
		self.manager = manager
	}
}
