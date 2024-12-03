//
//  ImageLoader.swift
//  MVVM_CollectionView_JSON_CoreData
//
//  Created by Mitya Kim on 12/2/24.
//

import UIKit
import Combine

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

    public func downloadImageUsingCombine(_ stringURL: String) -> Future<Data, NetworkError> {
        return Future { promise in
            guard let url = URL(string: stringURL) else {
                return promise(.failure(.invalidURL))
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    return promise(.failure(.networkError(error)))
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    return promise(.failure(.invalidResponse))
                }
                
                guard let data = data else {
                    return promise(.failure(.noData))
                }
                
                promise(.success(data))
            }.resume()
        }
    }
}
