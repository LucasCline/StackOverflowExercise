//
//  QuestionTableViewCell.swift
//  StackOverflowExercise
//
//  Created by Amanda Bloomer  on 2/1/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import UIKit

protocol StackOverflowQuestionTagDelegate {
    func tapped(tag: String)
}

class QuestionTableViewCell: UITableViewCell {
    static let identifier = "QuestionCell"
    var delegate: StackOverflowQuestionTagDelegate?
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var answerCount: UILabel!
    @IBOutlet weak var viewsCount: UILabel!
    @IBOutlet var collectionOfTagButtons: Array<UIButton>!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var score: UILabel!
    
    @IBAction func tagTapped(_ sender: Any) {
        guard let sender = sender as? UIButton else {
            print("tagTapped - failed to cast the sender as a UIButton")
            return
        }
        
        guard let tag = sender.titleLabel?.text else {
            print("tagTapped - there was no tag information found")
            return
        }
        
        delegate?.tapped(tag: tag)
    }
}
