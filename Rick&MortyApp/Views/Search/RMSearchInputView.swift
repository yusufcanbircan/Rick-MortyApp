//
//  RMSearchInputView.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 3.04.2023.
//

import UIKit

final class RMSearchInputView: UIView {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubview(searchBar)
        addConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor,constant: -5),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    
    // MARK: - Public
    
    public func configure(with viewModel: RMSearchInputViewViewModel) {
        searchBar.placeholder = viewModel.searchPlaceholderText
    }

}
