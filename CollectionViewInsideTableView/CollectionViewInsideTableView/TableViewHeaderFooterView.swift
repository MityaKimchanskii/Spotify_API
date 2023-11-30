//
//  TableViewHeaderFooterView.swift
//  CollectionViewInsideTableView
//
//  Created by Mitya Kim on 11/29/23.
//

import UIKit

class TableViewHeaderFooterView: UITableViewHeaderFooterView {
    static let id = "TableViewHeaderFooterView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: .zero, height: 10)
    }
}
