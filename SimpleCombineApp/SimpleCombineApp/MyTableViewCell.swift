//
//  MyTableViewCell.swift
//  SimpleCombineApp
//
//  Created by Mitya Kim on 12/2/24.
//

import UIKit
import Combine


final class MyTableViewCell: UITableViewCell {
    
    static let id = "MyTableViewCell"
    
    private let button = UIButton()
    
    let action = PassthroughSubject<String, Never>()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyTableViewCell {
    private func setup() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .primaryActionTriggered)
    }
    
    private func layout() {
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            button.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: button.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: button.bottomAnchor, multiplier: 1)
        ])
    }
    
    @objc private func didTapButton() {
        action.send("Hello Button!")
    }
}
