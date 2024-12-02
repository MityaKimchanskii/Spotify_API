//
//  CoinsDataTest.swift
//  MVVM_CollectionView_JSON_CoreDataTests
//
//  Created by Mitya Kim on 12/2/24.
//

import XCTest
@testable import MVVM_CollectionView_JSON_CoreData

final class CoinDataTest: XCTestCase {

    func testCanParseCoin() throws {
        let json = """
        
          {
            "symbol": "btc",
            "name": "Bitcoin",
            "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
            "current_price": 95652,
            "market_cap_change_percentage_24h": -0.6661,
          }
        
        """
        
        let jsonData = json.data(using: .utf8)!
        let coinData = try! JSONDecoder().decode(Coin.self, from: jsonData)
        
        XCTAssertEqual("btc", coinData.symbol)
        XCTAssertEqual("Bitcoin", coinData.name)
        XCTAssertEqual("https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", coinData.imageURL)
        XCTAssertEqual(95652, coinData.currentPrice)
        XCTAssertEqual(-0.6661, coinData.changePercentage)
    }
    
    func testCanParceCoinsViaJSONFile() throws {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "CoinsJSON", ofType: "json") else {
            fatalError("JSON not found")
        }
        
        print("\n\n\(pathString)\n\n")
        
        guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert JSON to String")
        }
        
        let jsonData = json.data(using: .utf8)!
        let coinData = try! JSONDecoder().decode([Coin].self, from: jsonData)
        
        XCTAssertEqual("btc", coinData.first?.symbol)
        XCTAssertEqual("Bitcoin", coinData.first?.name)
        XCTAssertEqual("https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", coinData.first?.imageURL)
        XCTAssertEqual(95652, coinData.first?.currentPrice)
        XCTAssertEqual(-0.65195, coinData.first?.changePercentage)
    }
}
