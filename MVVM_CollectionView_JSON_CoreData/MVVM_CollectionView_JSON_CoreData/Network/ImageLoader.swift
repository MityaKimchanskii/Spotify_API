//
//  ImageLoader.swift
//  MVVM_CollectionView_JSON_CoreData
//
//  Created by Mitya Kim on 12/2/24.
//

import UIKit


final class ImageLoader {
    
    static let shared = ImageLoader()
    
    private init() {}
    
    public func downloadImage(_ stringURL: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: stringURL) else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: url) { data, res, error in
            if let error = error {
                return completion(.failure(.networkError(error)))
            }
            
            guard let res = res as? HTTPURLResponse, res.statusCode == 200 else {
                return completion(.failure(.invalidResponse))
            }
            
            guard let data else { return completion(.failure(.noData)) }
            completion(.success(data))
            
        }.resume()
    }
}

