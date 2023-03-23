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
        }
        
        let type: `Type`
    }
    
    private let config: Config
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
}
