//
//  CharactersListViewControllerViewModel.swift
//  BobsBurgersApp
//
//  Created by Mitya Kim on 12/9/24.
//

import UIKit



final class CharactersListViewControllerViewModel: NSObject {
    
    enum SectionType {
        case main
    }
    
    private var characters = [Character]()
    private var filteredCharacters = [Character]()
    
    private var dataSource: UITableViewDiffableDataSource<SectionType, Character>?
    private var isSearching = false
    
    override init() {
        super.init()
        
        readCharactersFromJsonFile()
    }
    
    private func readCharactersFromJsonFile() {
        guard let filePath = Bundle.main.path(forResource: "Data", ofType: "json") else { fatalError("Please check file path!") }
        
        do {
            let data = try Data(contentsOf: URL(filePath: filePath))
            let result = try JSONDecoder().decode([Character].self, from: data)
            characters = result
            updateData(characters)
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
}

// MARK: - UITableViewDelegate
extension CharactersListViewControllerViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
}

// MARK: - UITableViewDiffableDataSource
extension CharactersListViewControllerViewModel {
    public func configureDataSource(tableView: UITableView) {
        dataSource = UITableViewDiffableDataSource<SectionType, Character>(tableView: tableView, cellProvider: { tableView, indexPath, character in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.id, for: indexPath) as? CharacterTableViewCell else {
                fatalError("Unsupported UITableViewCell!")
            }
            let viewModel = CharacterTableViewCellViewModel(character: character)
            cell.configure(with: viewModel)
            return cell
        })
    }
    
    private func updateData(_ characters: [Character]) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, Character>()
        snapshot.appendSections([.main])
        snapshot.appendItems(characters)
        DispatchQueue.main.async {
            self.dataSource?.apply(snapshot)
        }
    }
}

// MARK: - UISearchResultsUpdating
extension CharactersListViewControllerViewModel: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        
        filteredCharacters = characters.filter({ $0.name.lowercased().contains(filter.lowercased()) })
        updateData(filteredCharacters)
    }
}

// MARK: - UISearchBarDelegate
extension CharactersListViewControllerViewModel: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(characters)
    }
}
