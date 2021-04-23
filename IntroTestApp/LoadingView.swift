//
//  ShimmerView.swift
//  IntroTestApp
//
//  Created by Kiran Poudel on 4/21/21.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    
    /// stack view where shimmer items are places
    lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.style = .large
        view.startAnimating()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        generateChildrens()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func generateChildrens() {
        
        addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
