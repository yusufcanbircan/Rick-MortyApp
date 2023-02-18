//
//  RMCharactersViewController.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 14.02.2023.
//

import UIKit

/// Controller to show or search for Characters
final class RMCharactersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Characters"
        
        RMService.shared.execute(.listCharactersrequest, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print(String(describing: model))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    
    
    

}
