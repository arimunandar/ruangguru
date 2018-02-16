//
//  CategoryManager.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import Foundation
import RealmSwift

protocol ICategoryDataManager: class {
	func fetchCategory(onSuccess: @escaping (Results<CategoryEntity>)->Void, onFail: (()->Void)?)
}

class CategoryDataManager: ICategoryDataManager {
	
	func fetchCategory(onSuccess: @escaping (Results<CategoryEntity>) -> Void, onFail: (() -> Void)?) {
		
		RealmService.fetch(object: CategoryEntity.self, completion: { (results) in
			if results.count > 0 {
				onSuccess(results)
			} else {
				BaseClient<CategoryEntityRoot>.fetchData(client: Clients.init(client: .category), onSuccess: { (categories) in
					categories.trivia_categories?.forEach({ (category) in
						RealmService.save(object: category)
					})
					
					RealmService.fetch(object: CategoryEntity.self, completion: { (results) in
						onSuccess(results)
					})
				}) {
					onFail?()
				}
			}
		})
	}
}
