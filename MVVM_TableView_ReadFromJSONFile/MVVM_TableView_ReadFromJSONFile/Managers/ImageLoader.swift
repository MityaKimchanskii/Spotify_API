//
//  ImageLoader.swift
//  MVVM_TableView_ReadFromJSONFile
//
//  Created by Mitya Kim on 11/29/24.
//
import UIKit


final class ImageLoader {
    
    static let shared = ImageLoader()
    
    private var imageDataCashe = NSCache<NSString, NSData>()
    
    private init() {}
    
    public func downloadImage(_ urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else { return completion(.failure(.invalidURL)) }
        
        let key = url.absoluteString as NSString
        if let data = imageDataCashe.object(forKey: key) {
            completion(.success(data as Data))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, res, error in
            guard error == nil else { return completion(.failure(.invalidURL)) }
            
            if let res = res as? HTTPURLResponse {
                if res.statusCode != 200 {
                    print("Status Code: \(res.statusCode)")
                }
            }
            
            guard let data else { return completion(.failure(.noData)) }
            
            self.imageDataCashe.setObject(data as NSData, forKey: key)
            
            return completion(.success(data))
        }.resume()
    }
}
