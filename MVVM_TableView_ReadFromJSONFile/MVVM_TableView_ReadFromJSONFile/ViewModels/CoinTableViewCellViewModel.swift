//
//  CoinTableViewCellViewModel.swift
//  MVVM_TableView_ReadFromJSONFile
//
//  Created by Mitya Kim on 11/29/24.
//
import UIKit
import Combine


final class CoinTableViewCellViewModel {
        
    let coin: Coin
    var image: UIImage?
    var onImageDowloaded: (() -> Void)?
    
    var formattedPrice: String {
        return String(format: "$%.2f", coin.currentPrice)
    }

    init(coin: Coin) {
        self.coin = coin
        fetchImage()
    }
    
    public func fetchImage() {
        ImageLoader.shared.downloadImage(coin.imageURL) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                    self?.onImageDowloaded?()
                }
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
                
            }
        }
    }
}
