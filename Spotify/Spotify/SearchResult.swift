//
//  SearchResult.swift
//  Spotify
//
//  Created by Mitya Kim on 4/18/23.
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
