//
//  MessageCell.swift
//  IntroTestApp
//
//  Created by Kiran Poudel on 4/21/21.
//

import Foundation
import UIKit

final class MessageCell: UITableViewCell {
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is message"
        label.backgroundColor = UIColor(named: "lightBackground")
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.transform = CGAffineTransform (scaleX: 1,y: -1)
        contentView.addSubview(messageLabel)
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0),
            messageLabel.heightAnchor.constraint(equalToConstant: 180.0)
        ])
    }
}
