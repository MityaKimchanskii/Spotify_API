//
//  AudioTrack.swift
//  Spotify
//
//  Created by Mitya Kim on 4/11/23.
//

import Foundation

struct AudioTrack: Codable {
    let album: Album?
    let artists: [Artist]
    let available_markets: [String]
//    let disk_number: Int?
    let preview_url: String?
    let duration_ms: Int
    let explicit: Bool
    let external_urls: [String: String]
    let id: String
    let name: String
}
