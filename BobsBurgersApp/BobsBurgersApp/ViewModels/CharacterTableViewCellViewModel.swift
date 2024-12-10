//
//  CharacterTableViewCellViewModel.swift
//  BobsBurgersApp
//
//  Created by Mitya Kim on 12/9/24.
//
import UIKit



final class CharacterTableViewCellViewModel {
    
    let character: Character
    var image: UIImage?
    var isImageLoaded: (() -> ())?
    
    init(character: Character) {
        self.character = character
        fetchImage()
    }
    
    private func fetchImage() {
        guard let imageUrl = character.imageUrl else { return }
        
        ImageLoader.shared.downloadImage(imageUrl) { [weak self] result in
            switch result {
            case .success(let image):
                self?.image = image
                self?.isImageLoaded?()
            case .failure(let error):
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
}
