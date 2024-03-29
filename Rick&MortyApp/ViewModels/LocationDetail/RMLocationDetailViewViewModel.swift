//
//  RMLocationDetailViewViewModel.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 1.04.2023.
//

import Foundation

protocol RMLocationDetailViewViewModelDelegate: AnyObject {
    func didFetchLocationDetails()
}

final class RMLocationDetailViewViewModel {
    private let endpointUrl: URL?
    
    deinit {
        
    }
    
    private var dataTuple: (location: RMLocation, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchLocationDetails()
        }
    }
    
    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
    }
    
    public weak var delegate: RMLocationDetailViewViewModelDelegate?
    
    public private(set) var cellViewModels: [SectionType] = []
    
    // MARK: - Init
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }
    
    // MARK: - Public
    public func fetchLocation() {
        guard let url = endpointUrl,
              let request = RMRequest(url: url)
        else {
            return
        }
        
        RMService.shared.execute(request,
                                 expecting: RMLocation.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(location: model)
            case .failure:
                break
            }
        }
    }
    
    public func character(at index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else { return nil }
        
        return dataTuple.characters[index]
    }
    
    // MARK: - Private
    
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else { return }
        
        let location = dataTuple.location
        let characters = dataTuple.characters
        
        var createdString = location.created
        if let date = RMCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: createdString) {
            createdString = RMCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }
        
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Location Name", value: location.name),
                .init(title: "Type", value: location.type),
                .init(title: "Dimension", value: location.dimension),
                .init(title: "Created", value: createdString)
            ]),
            .characters(viewModel: characters.compactMap({ character in
                return RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
            }))
        ]
    }
    private let group = DispatchGroup()
    
    private func fetchRelatedCharacters(location: RMLocation) {
        
        let requests = location.residents.compactMap({
            return URL(string: $0)
        })
        let requestss: [RMRequest] = requests.compactMap({
            return RMRequest(url: $0)
        })
        
        
        var characters: [RMCharacter] = []
        
        for request in requestss {
            group.enter()
            RMService.shared.execute(request,
                                     expecting: RMCharacter.self) { result in

                defer {
                    self.group.leave()
                }
                
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                    break
                }
            }
        }
//        DispatchQueue.main.async {
//            self.dataTuple = (
//                location: location,
//                characters: characters
//            )
//        }
        
        
        group.notify(queue: .main) {
            self.dataTuple = (
                location: location,
                characters: characters
            )
        }
    }
}
