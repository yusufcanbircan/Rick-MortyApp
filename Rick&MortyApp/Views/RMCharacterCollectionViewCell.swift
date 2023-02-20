//
//  RMCharacterCollectionViewCell.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 20.02.2023.
//

import UIKit

final class RMCharacterCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(_ viewModel: RMCharacterCollectionViewCellViewModel) {
        
    }
}
