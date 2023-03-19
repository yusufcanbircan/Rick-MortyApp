//
//  RMEpisodeDetailViewController.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 18.03.2023.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {
    private let url: URL?
    
    // MARK: - Init
    
    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        title = "Episode"
    }
}
