//
//  StrokeAndPathAnimation.swift
//  ViewAnimation
//
//  Created by Dmitrii Kim on 12/8/23.
//

import UIKit


class StrokeAndPathAnimationViewController: UIViewController {
    
    private var refreshView: RefreshView?
    private let kRefreshViewHeight: CGFloat = 110.0
    
    private let fruits: [String] = [
        "🍏 Green Apple",
        "🍊 Orange",
        "🍓 Strawberry",
        "🥝 Kiwi",
        "🍌 Banana"
    ]
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "hello"
        style()
        setupTableView()
        layout()
    }
}

// MARK: - Extensions
extension StrokeAndPathAnimationViewController {
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func style() {
        view.backgroundColor = .systemOrange
        self.title = "Fruit list"
        
        let refreshRect = CGRect(
            x: 0.0,
            y: -kRefreshViewHeight,
            width: view.frame.size.width,
            height: kRefreshViewHeight)
        let refreshView = RefreshView(frame: refreshRect, scrollView: self.tableView)
        refreshView.delegate = self
        view.addSubview(refreshView)
        self.refreshView = refreshView
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func delay(seconds: Double, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
}

extension StrokeAndPathAnimationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = fruits[indexPath.row]
        return cell
    }
}


extension StrokeAndPathAnimationViewController: RefreshViewDelegate {
    func refreshViewDidRefresh(_ refreshView: RefreshView) {
        delay(seconds: 4) {
            refreshView.endRefreshing()
        }
    }
}

extension StrokeAndPathAnimationViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshView?.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        refreshView?.scrollViewDidScroll(scrollView)
    }
}
