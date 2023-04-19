//
//  Artist.swift
//  Spotify
//
//  Created by Mitya Kim on 4/11/23.
//

import Foundation


struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let images: [APIImage]?
    let external_urls: [String: String]
}
