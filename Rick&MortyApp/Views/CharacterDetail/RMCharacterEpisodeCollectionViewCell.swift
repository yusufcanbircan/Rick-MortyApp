//
//  RMCharacterEpisodeCollectionViewCell.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 17.03.2023.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterEpisodeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        
    }
}
