//
//  Coin.swift
//  MVVM_TableView_ReadFromJSONFile
//
//  Created by Mitya Kim on 11/29/24.
//
import Foundation


struct Coin: Codable {
    let name: String
    let imageURL: String
    let symbol: String
    let currentPrice: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image"
        case symbol
        case currentPrice = "current_price"
    }
}

