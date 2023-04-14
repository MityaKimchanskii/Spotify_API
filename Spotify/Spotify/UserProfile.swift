//
//  UserProfile.swift
//  Spotify
//
//  Created by Mitya Kim on 4/11/23.
//

import Foundation


struct UserProfile: Codable {
    let country: String
    let display_name: String
//    let email: String
//    let explicit_content: [String: Int]
//    let external_urls: [String: String]
//    let followers: [String: Codable?]
    let id: String
    let product: String
    let images: [APIImage]
}

