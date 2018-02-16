//
//  CategoryCollectionViewCell.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/16/18.
//  Copyright © 2018 Ari Munandar. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var bgImage: UIImageView!
	@IBOutlet weak var iconImage: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }

}
