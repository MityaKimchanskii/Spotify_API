//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Mitya Kim on 1/10/25.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completion: @escaping (NetworkError?) -> Void) {
        retriveFavorites { result in
            switch result {
            case .success(let favorites):
                var arrayFavorites = favorites
                switch actionType {
                case .add:
                    guard !arrayFavorites.contains(favorite) else {
                        completion(.noData)
                        return
                    }
                    arrayFavorites.append(favorite)
                case .remove:
                    arrayFavorites.removeAll { $0.login == favorite.login }
                }
                completion(save(favorites: arrayFavorites))
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func retriveFavorites(completion: @escaping (Result<[Follower], NetworkError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let followers = try JSONDecoder().decode([Follower].self, from: favoritesData)
            completion(.success(followers))
        } catch {
            completion(.failure(.unableToDecode))
        }
    }
    
    static func save(favorites: [Follower]) -> NetworkError? {
        do {
            let encodedFavorites = try JSONEncoder().encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToDecode
        }
    }
}
