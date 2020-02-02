//
//  QuestionTableViewCell.swift
//  StackOverflowExercise
//
//  Created by Amanda Bloomer  on 2/1/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    static let identifier = "QuestionCell"
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var answerCount: UILabel!
    @IBOutlet weak var viewsCount: UILabel!
    @IBOutlet var collectionOfTagButtons: Array<UIButton>!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var score: UILabel!
}
