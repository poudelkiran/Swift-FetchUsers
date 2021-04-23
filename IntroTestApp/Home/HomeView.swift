//
//  HomeView.swift
//  IntroTestApp
//
//  Created by Kiran Poudel on 4/21/21.
//

import Foundation
import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellReuseIdentifier: String(describing: cellClass.identifier))
    }
}
final class HomeView: UIView {
    lazy var tableView: CustomTableView = {
        let view = CustomTableView()
        view.registerCell(MessageCell.self)
        view.transform = CGAffineTransform (scaleX: 1,y: -1);
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        generateChildrens()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func generateChildrens() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8.0),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8.0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
