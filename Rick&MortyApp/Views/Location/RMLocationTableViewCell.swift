//
//  RMLocationTableViewCell.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 30.03.2023.
//

import UIKit

final class RMLocationTableViewCell: UITableViewCell {
    public static let cellIdentifier = "RMLocationTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: RMLocationTableViewCellViewModel) {
        
    }
}
