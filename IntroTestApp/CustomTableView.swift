//
//  CustomTableView.swift
//  IntroTestApp
//
//  Created by Kiran Poudel on 4/21/21.
//

import Foundation
import UIKit


/// Error view selection delegate
protocol ErrorViewSelection {
    func didTappedRetryButton()
}

/// custom table view
class CustomTableView: UITableView {
    
    /// delegate
    var errorViewDelegate: ErrorViewSelection?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        estimatedRowHeight = 55.0
        rowHeight = UITableView.automaticDimension
        separatorStyle = .none
        alwaysBounceVertical = false
        backgroundColor = .white
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// set background view
    /// - Parameter type: loading type
    func setBackgroundView(of type: LoadType) {
        switch type {
        case .loading: setLoadingView()
        case .loaded(let errorType):
            setMessageView(of: errorType)
        }
    }
    
    /// set loading view as background view
    private func setLoadingView() {
        let loaderView = LoadingView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        
        self.backgroundView = loaderView
    }
    
    /// set message view
    /// - Parameter type: type of messages
    func setMessageView(of type: NetworkingError) {
        let errorView = ErrorView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        errorView.transform = CGAffineTransform (scaleX: 1,y: -1);
        errorView.retryButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        errorView.message = type.localizedDescription
        self.backgroundView = errorView
    }
    
    /// restore tableview
    func restore() {
        self.backgroundView = nil
    }
    
    /// retry button tapped event
    @objc func buttonTapped() {
        errorViewDelegate?.didTappedRetryButton()
    }
}
