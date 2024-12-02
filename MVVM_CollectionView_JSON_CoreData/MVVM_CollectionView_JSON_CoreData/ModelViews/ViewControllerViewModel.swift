//
//  ViewControllerViewModel.swift
//  MVVM_CollectionView_JSON_CoreData
//
//  Created by Mitya Kim on 12/1/24.
//

import UIKit


final class ViewControllerViewModel: NSObject {
    
    private var coins = [Coin]()
    
    override init() {
        super.init()
        
        readJsonFile()
    }
}

// MARK: - Helper Methods
extension ViewControllerViewModel {
    private func readJsonFile() {
        guard let path = Bundle.main.path(forResource: "Data", ofType: "json") else { return }
        
        do {
            let data = try Data(contentsOf: URL(filePath: path))
            let result = try JSONDecoder().decode([Coin].self, from: data)
            coins = result
        } catch {
            print("ERROR \(error.localizedDescription)")
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ViewControllerViewModel: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.id, for: indexPath) as? MyCollectionViewCell else {
            fatalError("Unsupported UICollectionViewCell")
        }
        let coin = coins[indexPath.row]
        cell.configure(with: MyCollectionViewCellViewModel(coin: coin))
        return cell
    }
}


// MARK: - UICollectionViewDelegate
extension ViewControllerViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row + 1)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewControllerViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ViewSizeContstants.collectionViewWidth, height: ViewSizeContstants.collectionViewItemHeight)
    }
}

