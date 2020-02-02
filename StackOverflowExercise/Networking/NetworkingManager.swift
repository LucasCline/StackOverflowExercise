//
//  NetworkingManager.swift
//  StackOverflowExercise
//
//  Created by Amanda Bloomer  on 1/31/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import Foundation

struct QueryParameter {
    var key: String
    var value: String
}

struct NetworkingManager {
    func fetchQuestions(queryParameters: [QueryParameter]? = nil, completionHandler: @escaping (StackOverflowResponse) -> ()) {
        //if no query params are provided, we default with the questions from stackoverflow in ascending order based on activity (most recent questions first)
        var queryParams: String
        if let queryParameters = queryParameters {
            queryParams = build(queryParameters: queryParameters)
        } else {
            queryParams = "?order=desc&sort=activity&site=stackoverflow"
        }
        
        guard let url = URL(string: "https://api.stackexchange.com/questions\(queryParams)") else {
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
                let stackOverflowResponse = try JSONDecoder().decode(StackOverflowResponse.self, from: data)
                completionHandler(stackOverflowResponse)
            } catch let decodingError {
                print(decodingError)
            }
        }

        task.resume()
    }
    
    private func build(queryParameters: [QueryParameter]) -> String {
        var queryString: String  = "?"
        for queryParameter in queryParameters {
            queryString += "\(queryParameter.key)=\(queryParameter.value)&"
        }
        
        queryString.removeLast(1)
        
        return queryString
    }
}
