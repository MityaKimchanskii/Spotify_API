//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/5/24.
//
import UIKit


final class GFAvatarImageView: UIImageView {
    
    private let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = UIImage(systemName: "bitcoinsign.circle.fill")
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, res, error in
            if error != nil { return }
            guard let res = res as? HTTPURLResponse, res.statusCode == 200 else { return }
            guard let data else { return }
            guard let image = UIImage(data: data) else { return }
            
            self?.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
}
