//
//  StackOverflowResponseModel.swift
//  StackOverflowExercise
//
//  Created by Amanda Bloomer  on 1/31/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import Foundation

struct StackOverflowResponseModel: Codable {
    var questions: [StackOverflowQuestionModel]
    var hasMore: Bool
    var quotaMax: Int
    var quotaRemaining: Int
    enum CodingKeys: String, CodingKey {
        case questions = "items"
        case hasMore = "has_more"
        case quotaMax = "quota_max"
        case quotaRemaining = "quota_remaining"
    }
}

struct StackOverflowQuestionModel: Codable {
    var tags: [String]
    var owner: StackOverflowOwnerModel
    var isAnswered: Bool
    var viewCount: Int
    var answerCount: Int
    var score: Int
    var lastActivityDate: Date
    var creationDate: Date
    var questionId: Int
    var link: String
    var title: String
    enum CodingKeys: String, CodingKey {
        case tags
        case owner
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case answerCount = "answer_count"
        case score = "score"
        case lastActivityDate = "last_activity_date"
        case creationDate = "creation_date"
        case questionId = "question_id"
        case link
        case title
    }
}

struct StackOverflowOwnerModel: Codable {
    var reputation: Int
    var userId: Int
    var userType: String
    var acceptRate: Int?
    var profileImage: String
    var displayName: String
    var link: String
    enum CodingKeys: String, CodingKey {
        case reputation
        case userId = "user_id"
        case userType = "user_type"
        case acceptRate = "accept_rate"
        case profileImage = "profile_image"
        case displayName = "display_name"
        case link
    }
}
