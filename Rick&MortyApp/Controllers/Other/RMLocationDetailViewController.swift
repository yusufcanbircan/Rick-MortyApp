//
//  RMLocationDetailViewController.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 1.04.2023.
//

import UIKit

final class RMLocationDetailViewController: UIViewController {
    
    private let location: RMLocation
    
    // MARK: - Init
    
    init(location: RMLocation) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
    }

}
