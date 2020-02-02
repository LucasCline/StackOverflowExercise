//
//  QuestionDetailWebViewController.swift
//  StackOverflowExercise
//
//  Created by Amanda Bloomer  on 2/1/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import UIKit
import WebKit

class QuestionDetailWebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var request: URLRequest?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRequest()
    }
    
    private func loadRequest() {
        guard let request = self.request else {
            print("Request not found - unable to load")
            return
        }
        
        webView.load(request)
    }
}
