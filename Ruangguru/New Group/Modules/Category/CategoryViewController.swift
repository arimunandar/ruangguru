//
//  CategoryViewController.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

protocol ICategoryViewController: class {
	
}

class CategoryViewController: UIViewController {

	var presenter: ICategoryPresenter?

	override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension CategoryViewController: ICategoryViewController {
	
}

extension CategoryViewController {
	
}

extension CategoryViewController {
	
}
