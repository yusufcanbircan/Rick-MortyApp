//
//  RMCharacterStatus.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 15.02.2023.
//

import Foundation

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unkown"
        }
    }
}
