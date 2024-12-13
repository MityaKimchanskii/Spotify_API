//
//  CharacterListViewControllerViewModel.swift
//  BobsBurgersFullCycleApp
//
//  Created by Mitya Kim on 12/12/24.
//

import UIKit


final class CharacterListViewControllerViewModel: NSObject {
    
    private var characters: [Character] = []
    private let dataProvider: DataProvider
    private let imageLoader: ImageLoaderProtocol

    enum SectionType {
        case main
    }
    
    private var dataSource: UITableViewDiffableDataSource<SectionType, Character>?
    
    init(dataProvider: DataProvider, imageLoader: ImageLoaderProtocol) {
        self.dataProvider = dataProvider
        self.imageLoader = imageLoader
        super.init()
        
        self.loadCharacters()
    }
}

// MARK: - UITableViewDiffableDataSource
extension CharacterListViewControllerViewModel {
    func setupDataSourcef(for tableView: UITableView) {
        dataSource = UITableViewDiffableDataSource<SectionType, Character>(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, character in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.id, for: indexPath) as? CharacterTableViewCell else { return UITableViewCell() }
            let viewModel = CharacterTableViewCellViewModel(character: character)
            cell.configure(with: viewModel)
            
            self?.imageLoader.fetchImage(viewModel.character.imageURL, completion: { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.characteImageView.image = image
                    }
                case .failure(let error):
                    print("ERROR: \(error.localizedDescription)")
                }
            })
            
            return cell
        })
    }
    
    private func updateSnapshot(_ characters: [Character]) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, Character>()
        snapshot.appendSections([.main])
        snapshot.appendItems(characters)
        
        DispatchQueue.main.async {
            self.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
    
    private func loadCharacters() {
        characters = dataProvider.fetchCharacters()
        updateSnapshot(characters)
    }
}

// MARK: - UITabeleViewDelegate
extension CharacterListViewControllerViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
}
