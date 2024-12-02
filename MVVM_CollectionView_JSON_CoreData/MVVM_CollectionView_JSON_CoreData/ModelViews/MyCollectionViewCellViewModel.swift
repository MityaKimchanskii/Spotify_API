//
//  MyCollectionViewCellViewModel.swift
//  MVVM_CollectionView_JSON_CoreData
//
//  Created by Mitya Kim on 12/2/24.
//

import UIKit


final class MyCollectionViewCellViewModel {
    
    let coin: Coin
    var image: UIImage?
    
    var onImageDownloaded: (() -> Void)?
    
    var formattedPrice: String {
        return String(format: "%.2f", coin.currentPrice)
    }
    
    init(coin: Coin, image: UIImage? = nil) {
        self.coin = coin
        self.image = image
        
        fetchImage()
    }
    
    public func fetchImage() {
        ImageLoader.shared.downloadImage(coin.imageURL) { [weak self] result in
            switch result {
            case .success(let data):
                self?.image = UIImage(data: data)
                self?.onImageDownloaded?()
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
}
