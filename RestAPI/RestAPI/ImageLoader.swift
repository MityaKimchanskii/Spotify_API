//
//  ImageLoader.swift
//  RestAPI
//
//  Created by Mitya Kim on 5/13/23.
//

import UIKit

final class ImageLoader {
    
    static let shared = ImageLoader()
    private init() {}
    
    public func fetchImage(_ pokemon: Pokemon, completion: @escaping (Result<UIImage, ServiceError>) -> Void) {
        
        let imageURL = URLRequest(url: pokemon.sprites.spriteURL)
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            DispatchQueue.main.async {
                guard error == nil else { return completion(.failure(.thrownError)) }
                guard let data else { return completion(.failure(.noData)) }
                guard let image = UIImage(data: data) else { return completion(.failure(.invalidURL))}
                completion(.success(image))
            }
        }.resume()
    }
}
