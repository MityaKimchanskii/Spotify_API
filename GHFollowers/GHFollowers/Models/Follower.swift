//
//  Follower.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/5/24.
//

import Foundation


struct Follower: Codable, Hashable {
    let login: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
}
