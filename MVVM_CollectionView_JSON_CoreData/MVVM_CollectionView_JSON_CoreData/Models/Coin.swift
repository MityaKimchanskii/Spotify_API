//
//  Coin.swift
//  MVVM_CollectionView_JSON_CoreData
//
//  Created by Mitya Kim on 12/2/24.
//

import Foundation


struct Coin: Codable {
    let name: String
    let symbol: String
    let currentPrice: Double
    let imageURL: String
    let changePercentage: Double
    
    enum CodingKeys: String, CodingKey {
        case name, symbol
        case imageURL = "image"
        case currentPrice = "current_price"
        case changePercentage = "market_cap_change_percentage_24h"
    }
}

//"id": "bitcoin",
//"symbol": "btc",
//"name": "Bitcoin",
//"image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
//"current_price": 95652,
//"market_cap": 1893656461290,
//"market_cap_rank": 1,
//"fully_diluted_valuation": 2009563794764,
//"total_volume": 61465599209,
//"high_24h": 96513,
//"low_24h": 94716,
//"price_change_24h": -641.412777727383,
//"price_change_percentage_24h": -0.6661,
//"market_cap_change_24h": -12426757729.1082,
//"market_cap_change_percentage_24h": -0.65195,
//"circulating_supply": 19788765,
//"total_supply": 21000000,
//"max_supply": 21000000,
//"ath": 99645,
//"ath_change_percentage": -4.02613,
//"ath_date": "2024-11-22T19:35:49.770Z",
//"atl": 67.81,
//"atl_change_percentage": 140933.69397,
//"atl_date": "2013-07-06T00:00:00.000Z",
//"roi": null,
//"last_updated": "2024-11-29T01:41:30.269Z",
//"price_change_percentage_24h_in_currency": -0.666101166477251
