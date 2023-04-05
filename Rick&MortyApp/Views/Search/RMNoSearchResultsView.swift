//
//  RMNoSearchResultsView.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 3.04.2023.
//

import UIKit

final class RMNoSearchResultsView: UIView {
    
    private let viewModel = RMNoSearchResultsViewViewModel()
    
    private let iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .systemBlue
        return iconView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(iconView, label)
        addConstraint()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 90),
            iconView.heightAnchor.constraint(equalToConstant: 90),
            iconView.topAnchor.constraint(equalTo: topAnchor),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            
        ])
    }

    private func configure() {
        label.text = viewModel.title
        iconView.image = viewModel.image
    }
}
