//
//  CoinTableViewCellViewModel.swift
//  MVVM_TableView_ReadFromJSONFile
//
//  Created by Mitya Kim on 11/29/24.
//
import UIKit


final class CoinTableViewCellViewModel {
    
    let coin: Coin
    var image: UIImage?
    
    init(coin: Coin) {
        self.coin = coin
    
    }
    
    public func fetchImage() {
        ImageLoader.shared.downloadImage(coin.imageURL) { [weak self] result in
            switch result {
            case .success(let data):
                self?.image = UIImage(data: data)
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
}
