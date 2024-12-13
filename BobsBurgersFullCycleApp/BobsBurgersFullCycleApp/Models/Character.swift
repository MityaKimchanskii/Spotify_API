//
//  Character.swift
//  BobsBurgersFullCycleApp
//
//  Created by Mitya Kim on 12/12/24.
//

import Foundation


struct Character: Codable, Hashable {
    let name: String
    let imageURL: String
    let gender: String?
    let occupation: String?
    
    enum CodingKeys: String, CodingKey {
        case name, gender, occupation
        case imageURL = "image"
    }
}
