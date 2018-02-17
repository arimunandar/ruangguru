//
//  QuestionFinishView.swift
//  Ruangguru
//
//  Created by Ari Munandar on 2/17/18.
//  Copyright © 2018 ARTDEV INDONESIA. All rights reserved.
//

import UIKit

protocol QuestionFinishDelegate {
	func handleStartOver()
}

class QuestionFinishView: UIView {

	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var startOverButton: UIButton!
	
	var delegate: QuestionFinishDelegate?
	
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        self.startOverButton.layer.cornerRadius = self.startOverButton.frame.size.height / 2
    }

	@IBAction func handleStarOver(_ sender: Any) {
		self.delegate?.handleStartOver()
	}
}
