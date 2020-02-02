//
//  MainTableViewController.swift
//  StackOverflowExercise
//
//  Created by Amanda Bloomer  on 1/31/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import UIKit

class MainTableViewController: UIViewController {
    var delegate: MainTableViewDelegate?
    var linkForSegue: String?
    @IBOutlet weak var questionsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionsTableView.delegate = delegate
        questionsTableView.dataSource = delegate
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? QuestionDetailWebViewController else {
            print("Segue failed - destination segue is not of type QuestionDetailWebViewController)")
            return
        }
        
        guard let urlString = linkForSegue,
            let url = URL(string: urlString) else {
                print("Unable to form URL from provided string - \(String(describing: linkForSegue))")
                return
        }
        
        destinationVC.request = URLRequest(url: url)
    }
}
