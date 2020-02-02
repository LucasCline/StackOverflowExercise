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
    var cache: NSCache<AnyObject, AnyObject>?
    var questions: [StackOverflowQuestion]?
    weak var viewController: MainTableViewController?
    
    init(viewController: MainTableViewController, networkingManager: NetworkingManager, cache: NSCache<AnyObject,AnyObject>) {
        super.init()
        self.viewController = viewController
        self.networkingManager = networkingManager
        
        fetchQuestions()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController?.linkForSegue = questions?[indexPath.row].link
        viewController?.performSegue(withIdentifier: "QuestionDetail", sender: viewController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as? QuestionTableViewCell else {
            print("Failed to cast UITableViewCell to cell with identifier - \(QuestionTableViewCell.identifier)")
            return UITableViewCell()
        }
        
        guard let questionForRow = questions?[indexPath.row] else {
            print("Unable to find question data for row - \(indexPath.row)")
            return cell
        }

        cell.title.text = String(htmlEncodedString: questionForRow.title)
        cell.answerCount.text = "\(questionForRow.answerCount)"
        cell.viewsCount.text = "\(questionForRow.viewCount) views"
        cell.score.text = "\(questionForRow.score)"
        cell.displayName.text = String(htmlEncodedString: questionForRow.owner?.displayName ?? "N/A")
        
        //set the labels on the array of tag buttons
        for (n, button) in cell.collectionOfTagButtons.enumerated() {
            guard let tag = questionForRow.tags[safeIndex: n] else {
                print("No tag information found - will hide the tag button")
                button.isHidden = true
                continue
            }
            
            button.setTitle(tag, for: .normal)
        }
        
        cell.profileImage.image = nil
        if let cachedImage = cache?.object(forKey: indexPath.row as AnyObject) as? UIImage {
            cell.profileImage.image = cachedImage
        } else {
            cell.profileImage.loadFromURL(photoURL: questionForRow.owner?.profileImage)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    private func fetchQuestions() {
        networkingManager?.fetchQuestions(queryParameters: [QueryParameter(key: "order", value: "desc"),
                                                            QueryParameter(key: "sort", value: "activity"),
                                                            QueryParameter(key: "site", value: "stackoverflow")]) { (response) in
            self.questions = response.questions.filter { $0.isAnswered && $0.answerCount > 1 }
            DispatchQueue.main.async {
                self.viewController?.questionsTableView.reloadData()
            }
        }
    }
}
