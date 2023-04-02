//
//  RMSearchViewController.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 23.03.2023.
//

import UIKit

final class RMSearchViewController: UIViewController {

    struct Config {
        enum `Type` {
            case character
            case location
            case episode
            
            var title: String {
                switch self {
                case .character:
                    return "Search Character"
                case .episode:
                    return "Search Location"
                case .location:
                    return "Search Episode"
                }
            }
        }
        
        let type: `Type`
    }
    
    private let config: Config
    
    // MARK: - Init
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = config.type.title
        view.backgroundColor = .systemBackground
    }
}
