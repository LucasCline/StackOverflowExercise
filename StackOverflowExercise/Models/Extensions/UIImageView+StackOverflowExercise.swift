//
//  UIImageView+StackOverflowExercise.swift
//  StackOverflowExercise
//
//  Created by Amanda Bloomer  on 2/2/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadFromURL(photoURL: String?) {
        guard let urlString = photoURL,
            let url = URL(string: urlString) else {
                print("UIImageView loadFromURL - Could not create url with string \(String(describing: photoURL))")
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession.shared

        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Failed to download image from URL - \(String(describing: photoURL)) with error - \(String(describing: error))")
                return
            }
            
            guard let imageData = data else {
                print("No data found for image at URL - \(String(describing: photoURL))")
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
        dataTask.resume()
    }
}
