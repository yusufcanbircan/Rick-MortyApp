//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 17.03.2023.
//

import Foundation

final class RMCharacterEpisodeCollectionViewCellViewModel {
    private let episodeDataUrl: URL?
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
}
