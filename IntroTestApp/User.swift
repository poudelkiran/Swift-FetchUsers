//
//  User.swift
//  IntroTestApp
//
//  Created by Kiran Poudel on 4/22/21.
//

import Foundation

/// Users
struct User: Codable {
    var id: Int
    var firstName: String
    var lastName: String
    
    func getFullName() -> String {
        return firstName+" "+lastName
    }
    init(firstName: String, lastName: String) {
        self.id = 1
        self.firstName = firstName
        self.lastName = lastName
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
