//
//  QuestionCollectionViewCell.swift
//  Ruangguru
//
//  Created by GREDU on 2/16/18.
//  Copyright © 2018 Ari Munandar. All rights reserved.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var optionLabel: UILabel!
	@IBOutlet weak var answerLabel: UILabel!
	@IBOutlet weak var resultAnswerLabel: UILabel!
	
	enum AnswerState {
		case correct
		case wrong
		case normal
	}
	
	override var isSelected: Bool{
		didSet{
			if self.isSelected {
				self.setColor(firstColor: UIColor.aquaMarine, secondColor: .white, state: .correct)
			} else {
				self.setColor(firstColor: UIColor.white, secondColor: .darkGray)
			}
		}
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		self.optionLabel.layer.cornerRadius = self.optionLabel.frame.size.width / 2
		self.optionLabel.layer.borderColor = UIColor.darkGray.cgColor
		self.optionLabel.layer.borderWidth = 1
		
		self.layer.borderColor = UIColor.gray.cgColor
		self.layer.borderWidth = 1
		self.layer.cornerRadius = 10
    }
	
	func selectAnswer(state: AnswerState) {
		switch state {
		case .correct:
			self.setColor(firstColor: UIColor.aquaMarine, secondColor: .white, state: .correct)
		case .wrong:
			self.setColor(firstColor: UIColor.coral, secondColor: .white, state: .wrong)
		case .normal:
			self.setColor(firstColor: UIColor.white, secondColor: .darkGray)
		}
	}
	
	private func setColor(firstColor: UIColor, secondColor: UIColor, state: AnswerState = .normal) {
		self.backgroundColor = firstColor
		self.answerLabel.textColor = secondColor
		self.resultAnswerLabel.textColor = secondColor
		self.optionLabel.layer.borderColor = secondColor.cgColor
		self.layer.borderColor = firstColor.cgColor
		
		switch state {
		case .normal:
			self.optionLabel.textColor = .darkGray
			self.optionLabel.backgroundColor = .white
			self.layer.borderColor = UIColor.gray.cgColor
		default:
			self.optionLabel.textColor = firstColor
			self.optionLabel.backgroundColor = secondColor
		}
	}

}
