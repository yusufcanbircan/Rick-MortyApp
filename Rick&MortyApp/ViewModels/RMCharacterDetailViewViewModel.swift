//
//  RMCharacterDetailViewViewModel.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 4.03.2023.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    private let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
}

