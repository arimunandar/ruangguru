//
//  QuestionViewController.swift
//  Ruangguru
//
//  Created by GREDU on 2/16/18.
//  Copyright (c) 2018 ARTDEV INDONESIA. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit
import RealmSwift

class QuestionData {
	var index: Int?
	var question: String?
	
	init(index: Int, question: String) {
		self.index = index
		self.question = question
	}
}

protocol IQuestionViewController: class {
	func displayQuestionData(data: Results<QuestionEntity>)
}

class QuestionViewController: UIViewController {

	@IBOutlet weak var questionLabel: UILabel!
	@IBOutlet weak var correctAnswerLabel: UILabel!
	@IBOutlet weak var questionDatailLabel: UILabel!
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var nextButton: UIButton!
	private lazy var blockerView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.white.withAlphaComponent(0)
		view.isHidden = true
		view.frame = self.collectionView.frame
		self.view.addSubview(view)
		return view
	}()
	
	var presenter: IQuestionPresenter?
	
	var selectAnswer: QuestionData?
	var correctAnswer: QuestionData?
	
	var data: Results<QuestionEntity>?
	var questionNumber: Int = 0
	var questions: [String] = []
	var totalCorrectAnswer: Int = 0
	
	enum SubmitState {
		case checkingAnswer
		case nextQuestion
		case finishGame
	}
	
	var checkingState: SubmitState = .checkingAnswer

	override func viewDidLoad() {
        super.viewDidLoad()
		
		self.nextButton.isEnabled = false
		
		if let title = self.presenter?.parameters?["categoryName"] as? String {
			self.navigationItem.title = title
		}
		
		if let categoryId = self.presenter?.parameters?["categoryId"] as? Int {
			self.presenter?.handleFetchQuestion(categoryId: categoryId)
		}

		self.setupComponent()
    }
	
	private func setupComponent() {
		self.collectionView.register(UINib(nibName: "QuestionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cells")
	}
	
	@IBAction func handleNextQuestion(_ sender: Any) {
		if self.selectAnswer != nil {
			switch self.checkingState {
			case .checkingAnswer:
				self.resultQuestion(onCorrect: {
					let correctCell = self.collectionView.cellForItem(at: IndexPath(item: self.selectAnswer?.index ?? 0, section: 0)) as! QuestionCollectionViewCell
					correctCell.selectAnswer(state: .correct)
					correctCell.resultAnswerLabel.isHidden = false
					correctCell.resultAnswerLabel.text = "Correct Answer!"
					self.totalCorrectAnswer += 1
					self.correctAnswerLabel.text = "\(self.totalCorrectAnswer) Right Answer"
				}, onWrong: {
					let correctCell = self.collectionView.cellForItem(at: IndexPath(item: self.correctAnswer?.index ?? 0, section: 0)) as! QuestionCollectionViewCell
					correctCell.selectAnswer(state: .correct)
					correctCell.resultAnswerLabel.isHidden = false
					correctCell.resultAnswerLabel.text = "Correct Answer!"
					let wrongCell = self.collectionView.cellForItem(at: IndexPath(item: self.selectAnswer?.index ?? 0, section: 0)) as! QuestionCollectionViewCell
					wrongCell.selectAnswer(state: .wrong)
					wrongCell.resultAnswerLabel.isHidden = false
					wrongCell.resultAnswerLabel.text = "Wrong Answer!"
				})
				self.blockerView.isHidden = false
				self.nextButton.setTitle("Next Question!", for: .normal)
				self.checkingState = .nextQuestion
			case .nextQuestion:
				self.blockerView.isHidden = true
				let correctCell = self.collectionView.cellForItem(at: IndexPath(item: self.correctAnswer?.index ?? 0, section: 0)) as! QuestionCollectionViewCell
				correctCell.resultAnswerLabel.isHidden = true
				let wrongCell = self.collectionView.cellForItem(at: IndexPath(item: self.selectAnswer?.index ?? 0, section: 0)) as! QuestionCollectionViewCell
				wrongCell.resultAnswerLabel.isHidden = true
				if self.questionNumber < self.data?.count ?? 0 {
					self.prepareData()
					self.nextButton.setTitle("Check Answer!", for: .normal)
					self.checkingState = .checkingAnswer
				} else {
					self.nextButton.setTitle("Finish Game!", for: .normal)
					self.checkingState = .finishGame
				}
			case .finishGame:
				print("Finish Game")
			}
		}
	}
	
	private func resultQuestion(onCorrect: ()->Void, onWrong: ()->Void) {
		if self.selectAnswer?.question ?? "" == self.correctAnswer?.question ?? "" {
			onCorrect()
		} else {
			onWrong()
		}
	}
	
	func prepareData() {
		self.nextButton.isEnabled = false
		self.nextButton.setTitle("Check Answer!", for: .normal)
		self.nextButton.addTarget(self, action: #selector(handleNextQuestion), for: .touchUpInside)
		self.questions = []
		self.questions.append(self.data?[self.questionNumber].correct_answer ?? "")
		self.data?[questionNumber].incorrect_answers.forEach({ (option) in
			self.questions.append(option)
		})
		
		self.questions = self.questions.shuffled()
		
		for (key, q) in self.questions.enumerated() {
			if q == self.data?[self.questionNumber].correct_answer ?? "" {
				self.correctAnswer = QuestionData(index: key, question: q)
			}
		}
		
		self.collectionView.reloadData()
		self.correctAnswerLabel.text = "\(self.totalCorrectAnswer) Right Answer"
		self.questionLabel.text = "Question No. \(self.questionNumber + 1)"
		self.questionDatailLabel.text = self.data?[self.questionNumber].question?.html2String
		self.questionNumber += 1
	}
}

extension QuestionViewController: IQuestionViewController {
	
	func displayQuestionData(data: Results<QuestionEntity>) {
		self.data = data
		self.prepareData()
	}
}

extension QuestionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = self.view.frame.size.width - 24
		return CGSize(width: width / 2, height: 120)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.nextButton.isEnabled = true
		self.selectAnswer = QuestionData(index: indexPath.item, question: self.questions[indexPath.item])
	}
}

extension QuestionViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.questions.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cells", for: indexPath) as! QuestionCollectionViewCell
		cell.answerLabel.text = self.questions[indexPath.item].html2String
		switch indexPath.item {
		case 0:
			cell.optionLabel.text = "A"
		case 1:
			cell.optionLabel.text = "B"
		case 2:
			cell.optionLabel.text = "C"
		case 3:
			cell.optionLabel.text = "D"
		default:
			return cell
		}
		return cell
	}
}
