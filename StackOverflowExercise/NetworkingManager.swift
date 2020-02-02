//
//  NetworkingManager.swift
//  StackOverflowExercise
//
//  Created by Amanda Bloomer  on 1/31/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import Foundation

class NetworkingManager {
    func fetchQuestions(queryParameters: String? = nil, completionHandler: @escaping (StackOverflowResponseModel) -> ()) {
        //if no query params are provided, we default with the questions from stackoverflow in ascending order based on activity (most recent questions first)
        let queryParams = queryParameters ?? "order=desc&sort=activity&site=stackoverflow"
        guard let url = URL(string: "https://api.stackexchange.com/questions?\(queryParams)") else {
            print("Unable to create URL in fetchQuestions method with query parameters - \(queryParams)")
            return
        }

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let response = response else {
                print("No response from server for fetchQuestions method")
                return
            }
            
            guard response.isSuccessful else {
                print("Fetch Questions request was unsuccessful with response - \(response)")
                return
            }

            guard let data = data else {
                return
            }

            do {
                let stackOverflowResponse = try JSONDecoder().decode(StackOverflowResponseModel.self, from: data)
                completionHandler(stackOverflowResponse)
            } catch let decodingError {
                print(decodingError)
            }
        }

        task.resume()
    }
    
//    func getFilteredQuestions() -> [StackOverflowQuestionModel] {
//        return self.questions.filter { $0.isAnswered }.filter { $0.answerCount > 1 }
//    }
}
