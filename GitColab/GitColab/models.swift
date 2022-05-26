//
//  models.swift
//  GitColab
//
//  Created by Jin younkyum on 2022/05/26.
//

import Foundation
import UserNotifications


struct Event: Codable {
    let id: String
    let type: String
    let actor: Actor
    let repo: Repo
    let payload: Payload
    let is_public: Bool
    let created_at: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case actor
        case repo
        case payload
        case is_public = "public"
        case created_at
    }
}

struct Actor: Codable {
    let id: Int
    let login: String
    let display_login: String
    let gravatar_id: String
    let url: String
    let avatar_url: String

}

struct Repo: Codable {
    let id: Int
    let name: String
    let url: String
}

struct Payload: Codable {
    let push_id: Int?
    let size: Int?
    let distinct_size: Int?
    let ref: String?
    let head: String?
    let before: String?
    let commits: [Commits]?
}

struct Commits: Codable {
    let sha: String
    let author: Author
    let message: String
    let distinct: Bool
    let url: String
}

struct Author: Codable {
    let email: String
    let name: String
}
