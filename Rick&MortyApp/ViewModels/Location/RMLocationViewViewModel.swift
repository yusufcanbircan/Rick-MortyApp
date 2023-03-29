//
//  RMLocationViewViewModel.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 29.03.2023.
//

import Foundation

final class RMLocationViewViewModel {
    
    private var locations: [RMLocation] = []
    private var cellViewModels: [String] = []
    
    private var hasMoreResult: Bool {
        return false
    }
    
    // MARK: Init
    
    init() {}
    
    // MARK: Public
    
    public func fetchLocations() {
        RMService.shared.execute(.listLocationsRequest,
                                 expecting: String.self) { result in
            switch result {
            case .success(let model):
                break
            case .failure(let error):
                break
            }
        }
    }
    
    // MARK: Private
    
}
