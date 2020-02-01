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
        let cell = UITableViewCell()
        cell.textLabel?.text = networkingManager?.questions[indexPath.row].title
        return cell
    }
    
    private func fetchQuestions() {
        networkingManager?.fetchQuestions {
            DispatchQueue.main.async {
                self.viewController?.questionsTableView.reloadData()
            }
        }
    }
}
