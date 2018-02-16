//
//  Extension+Global.swift
//  Ruangguru
//
//  Created by GREDU on 2/16/18.
//  Copyright © 2018 Ari Munandar. All rights reserved.
//

import Foundation
import UIKit

extension Data {
	var html2AttributedString: NSAttributedString? {
		do {
			return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
		} catch {
			print("error:", error)
			return  nil
		}
	}
	var html2String: String {
		return html2AttributedString?.string ?? ""
	}
}

extension String {
	var html2AttributedString: NSAttributedString? {
		return Data(utf8).html2AttributedString
	}
	var html2String: String {
		return html2AttributedString?.string ?? ""
	}
}

extension MutableCollection {
	/// Shuffles the contents of this collection.
	mutating func shuffle() {
		let c = count
		guard c > 1 else { return }
		
		for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
			let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
			let i = index(firstUnshuffled, offsetBy: d)
			swapAt(firstUnshuffled, i)
		}
	}
}

extension Sequence {
	/// Returns an array with the contents of this sequence, shuffled.
	func shuffled() -> [Element] {
		var result = Array(self)
		result.shuffle()
		return result
	}
}
