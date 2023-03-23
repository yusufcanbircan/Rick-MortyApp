//
//  RMEpisodeDetailViewViewModel.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 23.03.2023.
//

import Foundation

final class RMEpisodeDetailViewViewModel {
    private let endpointUrl: URL?
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        fetchEpisode()
    }
    
    private func fetchEpisode() {
        guard let url = endpointUrl,
              let request = RMRequest(url: url)
        else {
            return
        }
        
        RMService.shared.execute(request,
                                 expecting: RMEpisode.self) { result in
            switch result {
            case .success(let success):
            print(String(describing: success))
            case .failure:
                break
            }
        }
    }
}
