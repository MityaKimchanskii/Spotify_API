//
//  ImageLoader.swift
//  MVVM_TableView_ReadFromJSONFile
//
//  Created by Mitya Kim on 11/29/24.
//
import UIKit


final class ImageLoader {
    
    static let shared = ImageLoader()
    
    private let imageDataCache = NSCache<NSString, NSData>()
    
    private init() {
        NotificationCenter.default.addObserver(self,selector: #selector(clearCache), name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clearCache), name: UIApplication.didEnterBackgroundNotification, object: nil)
        imageDataCache.totalCostLimit = 50 * 1024 * 1024
    }
    
    public func downloadImage(_ urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            return completion(.failure(.invalidURL))
        }
        
        let key = url.absoluteString

        if let cachedData = imageDataCache.object(forKey: key as NSString) {
            completion(.success(cachedData as Data))
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                return completion(.failure(.networkError(error)))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return completion(.failure(.invalidResponse))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            self?.imageDataCache.setObject(data as NSData, forKey: key as NSString)
            
            completion(.success(data))
        }.resume()
    }
    
    @objc public func clearCache() {
        imageDataCache.removeAllObjects()
    }
}

