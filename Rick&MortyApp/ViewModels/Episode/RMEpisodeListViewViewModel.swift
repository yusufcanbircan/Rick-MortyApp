//
//  RMEpisodeListViewViewModel.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 23.03.2023.
//

import UIKit

protocol RMEpisodeListViewViewModelDelegate: NSObject {
    func didLoadInitialEpisodes()
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath])
    func didSelectEpisode(_ episode: RMEpisode)
}

final class RMEpisodeListViewViewModel: NSObject {
    
    public weak var delegate: RMEpisodeListViewViewModelDelegate?
    
    private var isLoadingMoreCharacter = false
    
    private var episodes: [RMEpisode] = [] {
        didSet {
            for episode in episodes {
//                let viewModel = RMEpisodeCollectionViewCellViewModel(
//                    characterName: character.name,
//                    characterStatus: character.status,
//                    characterImageUrl: URL(string: character.image)
//                )
//
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
                
            }
        }
    }
    
    private var cellViewModels: [RMCharacterEpisodeCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    // Fetch initial set of characters (20)
    public func fetchCharacters() {
        RMService.shared.execute(
            .listCharactersRequest,
            expecting: RMGetAllCharactersResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                
                self?.apiInfo = info
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// Paginate if additional characters needed
    public func fetchAdditionalCharacters(url: URL) {
        guard !isLoadingMoreCharacter else { return }
        
        isLoadingMoreCharacter = true
        guard let request = RMRequest(url: url) else {
            isLoadingMoreCharacter = false
            return
        }
        
        RMService.shared.execute(request,
                                 expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                let info = responseModel.info
                self.apiInfo = info
                
                let originalCount = self.characters.count
                let newCount = moreResults.count
                let total = newCount + originalCount
                let startingIndex = total - newCount
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                
                self.characters.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    self.delegate?.didLoadMoreCharacters(
                        with: indexPathsToAdd
                    )
                    self.isLoadingMoreCharacter = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                self.isLoadingMoreCharacter = false
            }
        }
        
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}

// MARK: - CollectionView

extension RMEpisodeListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMEpisodeCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? RMEpisodeCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        
        cell.configure(with: cellViewModels[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
            let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                for: indexPath) as? RMFooterLoadingCollectionReusableView
        else {
            fatalError("unsupported")
        }
        
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else { return .zero }
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        
        return CGSize(width: width,
                      height: width*1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}

// MARK: - ScrollView

extension RMEpisodeListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacter,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let nextUrl = URL(string: nextUrlString)
        else { return }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAdditionalCharacters(url: nextUrl)
            }
            t.invalidate()
        }
        
       
    }
}
