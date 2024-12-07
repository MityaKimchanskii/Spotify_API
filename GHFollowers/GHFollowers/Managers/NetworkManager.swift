//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/5/24.
//


import Foundation


final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.github.com/users"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower]?, NetworkError>) -> Void) {
        let endpoint = baseURL + "/\(username)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { data, res, error in
            if error != nil {
                return completion(.failure(.invalidURL))
            }
            
            if let res = res as? HTTPURLResponse, res.statusCode == 200 {
                print("Status code: \(res.statusCode)")
            } else {
                completion(.failure(.invalidURL))
                return
            }
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let followers = try JSONDecoder().decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.noData))
            }
        }.resume()
    }
}

