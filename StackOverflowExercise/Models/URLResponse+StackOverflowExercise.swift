//
//  URLResponse+StackOverflowExercise.swift
//  StackOverflowExercise
//
//  Created by Amanda Bloomer  on 1/31/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import Foundation

extension URLResponse {
    var isSuccessful: Bool {
        if let httpResponse = self as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) {
                return true
        } else {
            return false
        }
    }
}
