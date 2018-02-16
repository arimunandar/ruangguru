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
import RealmSwift

protocol ICategoryViewController: class {
	func displayData(data: Results<CategoryEntity>)
}

class CategoryViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	
	var presenter: ICategoryPresenter?
	
	var data: Results<CategoryEntity>?

	override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		self.navigationItem.title = "Category"
		self.presenter?.handleFetchCategory()
		self.setupComponent()
		
    }
	
	private func setupComponent() {
		self.collectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cells")
	}
}

extension CategoryViewController: ICategoryViewController {
	
	func displayData(data: Results<CategoryEntity>) {
		self.data = data
		self.collectionView.reloadData()
	}
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = self.view.frame.size.width - 24
		return CGSize(width: width / 2, height: 120)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.presenter?.navigateToQuestionPage(data: ["categoryId": self.data?[indexPath.item].id ?? 0, "categoryName": self.data?[indexPath.item].name ?? ""])
	}
}

extension CategoryViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.data?.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cells", for: indexPath) as! CategoryCollectionViewCell
		if let data = self.data?[indexPath.item] {
			cell.titleLabel.text = data.name ?? "-"
			cell.bgImage.image = UIImage(named: "\(data.id)")
			cell.iconImage.image = UIImage(named: "icon-\(data.id)")
		}
		return cell
	}
}
