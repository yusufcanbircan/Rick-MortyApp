//
//  RMLocationView.swift
//  Rick&MortyApp
//
//  Created by Yusuf Can Bircan on 29.03.2023.
//

import UIKit

protocol RMLocationViewDelegate: AnyObject {
    func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation)
}

final class RMLocationView: UIView {
    
    public weak var delegate: RMLocationViewDelegate?
    
    private var viewModel: RMLocationViewViewModel? {
        didSet {
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
            }
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.alpha = 0
        tableView.isHidden = true
        tableView.register(RMLocationTableViewCell.self,
                           forCellReuseIdentifier: RMLocationTableViewCell.cellIdentifier)
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        
        return spinner
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        spinner.startAnimating()
        addSubviews(tableView, spinner)
        addConstraints()
        setUpTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Private
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
    
    public func configure(with viewModel: RMLocationViewViewModel) {
        self.viewModel = viewModel
    }

}

extension RMLocationView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let locationModel = viewModel?.location(at: indexPath.row) else { return }
        delegate?.rmLocationView(self, didSelect: locationModel)
    }
}

extension RMLocationView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModels = viewModel?.cellViewModels else { fatalError() }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RMLocationTableViewCell.cellIdentifier,
            for: indexPath
        ) as? RMLocationTableViewCell else {
            fatalError()
        }
        let cellViewModel = cellViewModels[indexPath.row]
        cell.configure(with: cellViewModel)
        
        return cell
    }
}
