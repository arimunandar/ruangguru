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
import RealmSwift

protocol CategoryInteractorDelegate: class {
	func didSuccessFetchCategory(data: Results<CategoryEntity>)
}

protocol ICategoryInteractor: class {
	var delegate: CategoryInteractorDelegate? { get set }
	
	func fetchCategoryData()
}

class CategoryInteractor: ICategoryInteractor {
	
	var manager: ICategoryDataManager?
	var delegate: CategoryInteractorDelegate?
	
	init(manager: ICategoryDataManager) {
		self.manager = manager
	}
	
	func fetchCategoryData() {
		self.manager?.fetchCategory(onSuccess: { (categories) in
			self.delegate?.didSuccessFetchCategory(data: categories)
		}, onFail: nil)
	}
}
