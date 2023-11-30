//
//  Networking.swift
//  Skeleton
//
//  Created by Mitya Kim on 5/23/23.
//

import UIKit


enum NetworkError: Error {
    case serverError
    case decodingError
}

struct Profile: Codable {
    let id: Int
    let name: String
    let gender: String?
    let occupation: String?
    
    static func makeSceleton() -> Profile {
        return Profile(id: 1, name: "Dimon", gender: "male", occupation: "iOS Developer")
    }
}

final class Networking {
    
    static let shared = Networking()
    
    private init() {}
    
    func fetchCharacters(completion: @escaping (Result<[Profile], NetworkError>) -> Void) {
        let url = URL(string: "https://bobsburgers-api.herokuapp.com/characters/?limit=100")!
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                do {
                    let profiles = try JSONDecoder().decode([Profile].self, from: data)
                    completion(.success(profiles))
                } catch {
                    print(error)
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
    
    func fetchProfileImage(profileID: Int, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let url = URL(string: "https://bobsburgers-api.herokuapp.com/images/characters/\(profileID).jpg") else {
            completion(.failure(.serverError))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    completion(.failure(.decodingError))
                    return
                }
                completion(.success(image))
            }
        }.resume()
    }
}

