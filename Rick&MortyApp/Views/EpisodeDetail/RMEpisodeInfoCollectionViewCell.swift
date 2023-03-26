//
//  RMInfoCollectionViewCell.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 26.03.2023.
//

import UIKit

final class RMEpisodeInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMEpisodeInfoCollectionViewCell"
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        setUpLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Private
    
    private func setUpLayer() {
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.masksToBounds = true
        layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    // MARK: - Public
    
    public func configure(with viewModel: RMEpisodeInfoCollectionViewCellViewModel) {
        
    }
    
}

