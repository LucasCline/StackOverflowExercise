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
    @IBOutlet weak var questionsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionsTableView.delegate = delegate
        questionsTableView.dataSource = delegate
    }
}
