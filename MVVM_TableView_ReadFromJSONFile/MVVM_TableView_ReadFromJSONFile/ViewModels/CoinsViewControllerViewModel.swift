//
//  CoinsViewControllerViewModel.swift
//  MVVM_TableView_ReadFromJSONFile
//
//  Created by Mitya Kim on 11/29/24.
//
import UIKit


final class CoinsViewControllerViewModel: NSObject {
    
    private var coins = [Coin]()
    
    override init() {
        super.init()
        
        readJSONFile()
    }
}

// MARK: - Helper Methods
extension CoinsViewControllerViewModel {    
    private func readJSONFile() {
        guard let path = Bundle.main.path(forResource: "Data", ofType: "json") else { return }
        
        do {
            let data = try Data(contentsOf: URL(filePath: path))
            let result = try JSONDecoder().decode([Coin].self, from: data)
            coins = result
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
    }
}

// MARK: - UITableViewDelegate, UITableVeiwDataSource
extension CoinsViewControllerViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.id, for: indexPath) as? CoinTableViewCell else {
            fatalError("Unsupported UITableViewCell") }
        let coin = coins[indexPath.row]
        let coinViewModel = CoinTableViewCellViewModel(coin: coin)
        cell.configure(with: coinViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
}
