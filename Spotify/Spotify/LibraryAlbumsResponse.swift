//
//  LibraryAlbumsResponse.swift
//  Spotify
//
//  Created by Mitya Kim on 4/26/23.
//

import Foundation


struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}
