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



//"id": "the-open-network",
//"symbol": "ton",
//"name": "Toncoin",
//"image": "https://coin-images.coingecko.com/coins/images/17980/large/photo_2024-09-10_17.09.00.jpeg?1725963446",
//"current_price": 6.37,
//"market_cap": 16232613995,
//"market_cap_rank": 13,
//"fully_diluted_valuation": 32604144222,
//"total_volume": 600562392,
//"high_24h": 6.58,
//"low_24h": 6.25,
//"price_change_24h": -0.0369568765433703,
//"price_change_percentage_24h": -0.57646,
//"market_cap_change_24h": -115793473.245073,
//"market_cap_change_percentage_24h": -0.70829,
//"circulating_supply": 2547231829.21915,
//"total_supply": 5116262479.53651,
//"max_supply": null,
//"ath": 8.25,
//"ath_change_percentage": -22.52469,
//"ath_date": "2024-06-15T00:36:51.509Z",
//"atl": 0.519364,
//"atl_change_percentage": 1131.2194,
//"atl_date": "2021-09-21T00:33:11.092Z",
//"roi": null,
//"last_updated": "2024-11-29T01:41:28.481Z",
//"price_change_percentage_24h_in_currency": -0.576459528560504
