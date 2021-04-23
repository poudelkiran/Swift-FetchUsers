//
//  ErrorView.swift
//  IntroTestApp
//
//  Created by Kiran Poudel on 4/21/21.
//

import Foundation
import UIKit

class ErrorView: UIView {
    
    /// message
    var message: String = "" {
        didSet {
            messageLabel.text = message
        }
    }
    
    /// stack views to hold message and button
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    /// message label
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    /// retry button wrapper view
    lazy var buttonWrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// retry button
    lazy var retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Retry", for: .normal)
        button.backgroundColor = .blue
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5.0
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        generateChildrens()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func generateChildrens() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(buttonWrapper)
        
        buttonWrapper.addSubview(retryButton)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor).addDefault(priority: .defaultHigh),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor).addDefault(priority: .defaultHigh),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            
            retryButton.centerXAnchor.constraint(equalTo: buttonWrapper.centerXAnchor),
            retryButton.centerYAnchor.constraint(equalTo: buttonWrapper.centerYAnchor),
            retryButton.topAnchor.constraint(equalTo: buttonWrapper.topAnchor),
        ])
    }
}

extension NSLayoutConstraint {
    func addDefault(priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority =  priority
        return self
    }
}

