//
//  Playlist.swift
//  Spotify
//
//  Created by Mitya Kim on 4/11/23.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
