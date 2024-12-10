//
//  ImageLoader.swift
//  BobsBurgersApp
//
//  Created by Mitya Kim on 12/9/24.
//

import UIKit


final class ImageLoader {
    
    static let shared = ImageLoader()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func downloadImage(_ urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else { return completion(.failure(.invalidURL)) }
        
        let key = url.absoluteString
        if let cachedData = cache.object(forKey: key as NSString) {
            completion(.success(cachedData as UIImage))
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, res, error in
            if let error = error { return completion(.failure(.networkError(error))) }
            
            guard let res = res as? HTTPURLResponse, res.statusCode == 200 else { return completion(.failure(.invalidResponse)) }
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let image = UIImage(data: data) else { return }
            self?.cache.setObject(image, forKey: key as NSString)
            
            completion(.success(image))
        }.resume()
    }
}
