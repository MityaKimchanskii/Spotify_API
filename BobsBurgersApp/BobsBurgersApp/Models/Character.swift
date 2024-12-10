//
//  Character.swift
//  BobsBurgersApp
//
//  Created by Mitya Kim on 12/9/24.
//
import Foundation


struct Character: Codable, Hashable {
    let id: Int?
    let name: String
    let imageUrl: String?
    let gender: String?
    let occupation: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageUrl = "image"
        case gender, occupation
    }
}

