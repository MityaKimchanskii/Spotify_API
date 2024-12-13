//
//  LocalDataProvider.swift
//  BobsBurgersFullCycleApp
//
//  Created by Mitya Kim on 12/12/24.
//

import UIKit

protocol DataProvider {
    func fetchCharacters() -> [Character]
}


final class LocalDataProvider: DataProvider {
    func fetchCharacters() -> [Character] {
        guard let path = Bundle.main.path(forResource: "Data", ofType: "json") else { return [] }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return try JSONDecoder().decode([Character].self, from: data)
        } catch {
            print("ERROR decoding JSON file: \(error.localizedDescription)")
            return []
        }
    }
}
