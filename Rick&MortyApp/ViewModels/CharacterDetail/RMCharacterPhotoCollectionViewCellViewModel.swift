//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 17.03.2023.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel {
    private let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        RMImageLoader.shared.downloadImage(url: imageUrl, completion: completion)
    }
}
