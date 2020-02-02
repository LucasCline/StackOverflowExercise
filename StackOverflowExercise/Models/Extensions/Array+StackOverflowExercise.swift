//
//  Array+StackOverflowExercise.swift
//  StackOverflowExercise
//
//  Created by Amanda Bloomer  on 2/1/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import Foundation

extension Array {
    subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
