//
//  ViewController.swift
//  IntroTestApp
//
//  Created by Kiran Poudel on 4/21/21.
//

import UIKit
import Foundation

/// viewcontroller
class ViewController: UIViewController {
    
    // MARK: Properties
    /// screenview
    lazy var screenView: HomeView = {
        return HomeView()
    }()
    
    /// viewmodel
    lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        self.view = screenView
        setupTableView()
        observeEvents()
        viewModel.callAPI()
    }
}

extension ViewController {
    
    // MARK: Custom Methods
    /// setup table views
    private func setupTableView() {
        screenView.tableView.delegate = self
        screenView.tableView.dataSource = self
        screenView.tableView.errorViewDelegate = self
    }
    
    /// observe events of rx
    private func observeEvents() {
        viewModel.items.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.screenView.tableView.reloadData()
        }).disposed(by: viewModel.bag)
    }
}

// MARK: TableView Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableView = tableView as? CustomTableView else { assertionFailure("Unknown tableview found."); return 0 }
        tableView.restore()
        let items = viewModel.items.value.items
        if !items.isEmpty {
            tableView.restore()
            return items.count
        } else {
            tableView.setBackgroundView(of: viewModel.items.value.loadType)
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.identifier, for: indexPath) as! MessageCell
        let data = viewModel.items.value.items[indexPath.row]
        cell.messageLabel.text = data.getFullName()
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.items.value.items.count - 1 {
            viewModel.callAPI(of: indexPath)
        }
    }
}

// MARK: Error View Selection Delegate
extension ViewController: ErrorViewSelection {
    func didTappedRetryButton() {
        viewModel.items.accept(Data(items: []))
        viewModel.callAPI()
    }
}
