//
//  RMEndpoint.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 15.02.2023.
//

import Foundation

/// Represents unique API endpoint
@frozen enum RMEndpoint: String {
    /// Endpoint to get character info
    case character
    /// Endpoint to get episode info
    case episode
    /// Endpoint to get location info
    case location
}
