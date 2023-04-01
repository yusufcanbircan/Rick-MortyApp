//
//  RMLocationsViewController.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 14.02.2023.
//

import UIKit

/// Controller to show or search for Locations
final class RMLocationsViewController: UIViewController, RMLocationViewViewModelDelegate, RMLocationViewDelegate {
    
    private let primaryView = RMLocationView()
    private let viewModel = RMLocationViewViewModel()
    
    // MARK:- Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Locations"
        view.addSubview(primaryView)
        addSearchButton()
        addConstraints()
        primaryView.delegate = self
        viewModel.delegate = self
        viewModel.fetchLocations()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
        ])
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(didSearchTap)
        )
    }
    
    @objc
    private func didSearchTap() {
        let vc = RMSearchViewController(config: RMSearchViewController.Config(type: .location))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - LocationViewModel Delegate
    func didFetchInitialLocations() {
        primaryView.configure(with: viewModel)
    }
    
    // MARK: - LocationViewDelegate
    func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation) {
        let vc = RMLocationDetailViewController(location: location)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
