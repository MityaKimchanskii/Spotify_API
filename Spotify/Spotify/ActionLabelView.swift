//
//  ActionLabelView.swift
//  Spotify
//
//  Created by Mitya Kim on 4/24/23.
//

import UIKit



struct ActionLabelViewViewModel {
    let text: String
    let actionTitle: String
}

protocol ActionLabelViewDelegate: AnyObject {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView)
}

class ActionLabelView: UIView {
    
    private let label = UILabel()
    private let button = UIButton()
    private let stackView = UIStackView()
    
    weak var delegate: ActionLabelViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        activateButton()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ActionLabelView {
    private func style() {
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.link, for: .normal)
    }
    
    private func layout() {
        addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    func configure(with viewModel: ActionLabelViewViewModel) {
        label.text = viewModel.text
        button.setTitle(viewModel.actionTitle, for: .normal)
    }
    
    private func activateButton() {
        button.addTarget(self, action: #selector(didTapButton), for: .primaryActionTriggered)
    }
    
    @objc private func didTapButton() {
        delegate?.actionLabelViewDidTapButton(self)
        print("hello")
    }
}
