//
//  Pokemon.swift
//  RestAPI
//
//  Created by Mitya Kim on 5/13/23.
//


import Foundation

struct Pokemon: Codable {
    let name: String
    let id: Int
    let sprites: Sprite
}

struct Sprite: Codable {
    let spriteURL: URL
    
    enum CodingKeys: String, CodingKey {
        case spriteURL = "front_default"
    }
}
