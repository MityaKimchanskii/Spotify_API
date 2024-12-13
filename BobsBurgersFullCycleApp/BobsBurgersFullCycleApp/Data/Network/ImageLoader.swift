//
//  Untitled.swift
//  BobsBurgersFullCycleApp
//
//  Created by Mitya Kim on 12/12/24.
//

import UIKit

protocol NetworkSession {
    func dataTask(with url: URL, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: NetworkSession {}

protocol ImageLoaderProtocol {
    func fetchImage(_ urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}

final class ImageLoader: ImageLoaderProtocol {
    
    private let cachedImage = NSCache<NSString, UIImage>()
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchImage(_ urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else { return completion(.failure(.invalidURL)) }
        
        if let cachedImage = cachedImage.object(forKey: urlString as NSString) {
            return completion(.success(cachedImage))
        }
        
        session.dataTask(with: url) { [weak self] data, res, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let res = res as? HTTPURLResponse, res.statusCode == 200 else { return completion(.failure(.invalidResponce)) }
            guard let data = data, let image = UIImage(data: data) else { return completion(.failure(.noData)) }
            self?.cachedImage.setObject(image, forKey: urlString as NSString)
            completion(.success(image))
        }.resume()
    }
}
