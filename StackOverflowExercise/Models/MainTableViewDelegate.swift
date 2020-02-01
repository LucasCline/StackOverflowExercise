//
//  MainTableViewDelegate.swift
//  StackOverflowExercise
//
//  Created by Amanda Bloomer  on 1/31/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import UIKit

class MainTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    var networkingManager: NetworkingManager?
    weak var viewController: MainTableViewController?
    
    init(viewController: MainTableViewController, networkingManager: NetworkingManager) {
        super.init()
        self.viewController = viewController
        self.networkingManager = networkingManager
        
        fetchQuestions()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networkingManager?.questions.count ?? 10 //arbitrary default of 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as? QuestionTableViewCell else {
            print("Failed to dequeue reusable cell with Identifier \(QuestionTableViewCell.identifier)")
            return UITableViewCell()
        }
        
        let questionForRow = networkingManager?.questions[indexPath.row]

        cell.title.text = questionForRow?.title
        cell.answerCount.text = "\(questionForRow?.answerCount ?? 0)"
        cell.viewsCount.text = "\(questionForRow?.viewCount ?? 0) views"
        cell.score.text = "\(questionForRow?.score ?? 0)"
        cell.displayName.text = questionForRow?.owner.displayName
        
        //set the array of tag buttons
        for (n, button) in cell.collectionOfTagButtons.enumerated() {
            //this is to prevent an array out of index crash for now.
            if questionForRow?.tags.count ?? 0 >= n+1 {
                button.setTitle(questionForRow?.tags[n], for: .normal)
            } else {
                button.isHidden = true
            }
        }
        
        //cell.profileImage.image = placeholder
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    private func fetchQuestions() {
        networkingManager?.fetchQuestions {
            DispatchQueue.main.async {
                self.viewController?.questionsTableView.reloadData()
            }
        }
    }
}
