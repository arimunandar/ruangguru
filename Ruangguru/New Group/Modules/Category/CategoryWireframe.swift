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
	
}

class CategoryWireframe: ICategoryWireframe {
	
	weak var view: CategoryViewController?
	
	init(view: CategoryViewController) {
		self.view = view
	}
}
