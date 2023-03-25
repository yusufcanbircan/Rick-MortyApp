//
//  RMEpisodeDetailView.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 23.03.2023.
//

import UIKit

 final class RMEpisodeDetailView: UIView {
     
     private var viewModel: RMEpisodeDetailViewViewModel?
     
     private var collectionView: UICollectionView?
     
     private let spinner: UIActivityIndicatorView = {
         let spinner = UIActivityIndicatorView()
         spinner.translatesAutoresizingMaskIntoConstraints = false
         
         return spinner
     }()

     override init(frame: CGRect) {
         super.init(frame: frame)
         translatesAutoresizingMaskIntoConstraints = false
         backgroundColor = .red
         self.collectionView = createCollectionView()
         addConstraints()
     }
     
     required init?(coder: NSCoder) {
         fatalError()
     }
     
     private func addConstraints() {
         <#code#>
     }
     
     private func createCollectionView() -> UICollectionView {
         
         return UICollectionView
     }
     
     public func configure(with viewModel: RMEpisodeDetailViewViewModel) {
         self.viewModel = viewModel
     }
}
