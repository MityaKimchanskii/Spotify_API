//
//  Service.swift
//  RestAPI
//
//  Created by Mitya Kim on 5/13/23.
//

import Foundation

final class Service {
    
    static let shared = Service()
    private init() {}
    
    public func fetchPokemon(name: String, completion: @escaping(Result<Pokemon, ServiceError>) -> Void) {
        
        guard let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon") else {
            completion(.failure(.invalidURL))
            return
        }
        
        // 1 - URL
        let url = baseURL.appending(path: name.lowercased())
        
        // 2 - Data Task
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                
                // 3 - Error headling
                guard error == nil else { return completion(.failure(ServiceError.thrownError)) }
                
                // 4 - Check for Data
                guard let data = data else { return completion(.failure(.noData)) }
                
                // 5 - Decode Data
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    completion(.success(pokemon))
                } catch {
                    completion(.failure(ServiceError.unableToDecode))
                }
            }
        }.resume()
    }
}
