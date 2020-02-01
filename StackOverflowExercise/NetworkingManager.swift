//
//  NetworkingManager.swift
//  StackOverflowExercise
//
//  Created by Amanda Bloomer  on 1/31/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import Foundation

class NetworkingManager {
    
    func fetchQuestions() {
        //Get rid of the force unwrap
        //Make url string configurable or make a new method that is
        let url = URL(string: "https://api.stackexchange.com/questions?order=desc&sort=activity&site=stackoverflow")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            //Add this logic to an extension for readability -- not the whole guard, just the successful response bit
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                    print("Fetch Questions request was unsuccessful with response - \(String(describing: response))")
                return
            }
            
            guard let data = data else { return }
            do {
                let stackOverflowResponse = try JSONDecoder().decode(StackOverflowResponseModel.self, from: data)
                print(stackOverflowResponse)
            } catch let decodingError {
                print(decodingError)
            }
        }

        task.resume()
    }
}
