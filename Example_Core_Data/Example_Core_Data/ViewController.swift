//
//  ViewController.swift
//  Example_Core_Data
//
//  Created by Mitya Kim on 11/26/24.
//

import UIKit
import CoreData


class ViewController: UIViewController {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var models = [Item]()
    
    private var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        setup()
        layout()
    }
}

// MARK: - Helper Methods
extension ViewController {
    private func setup() {
        title = "Core Data"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func addButton() {
        let alert = UIAlertController(title: "New Item", message: "Enter new item", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else { return }
            
            self?.addNewItem(name: text)
        }))
        
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = models[indexPath.row]
        
        let alert = UIAlertController(title: "Action", message: "Choose Action", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
                        
        present(alert, animated: true)
    }
}

// MARK: - Core Data
extension ViewController {
    private func fetchAllItems() {
        do {
            models = try context.fetch(Item.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            // error
        }
    }
    
    private func addNewItem(name: String) {
        let newItem = Item(context: context)
        newItem.name = name
        
        do {
            try context.save()
            fetchAllItems()
        } catch {
            // error
        }
    }
    
    private func deleteItem(item: Item) {
        context.delete(item)
        
        do {
            try context.save()
            fetchAllItems()
        } catch {
            // error
        }
    }
}
