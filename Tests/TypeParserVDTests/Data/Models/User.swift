//
//  User.swift
//  
//
//  Created by Victor Capilla Developer on 4/10/20.
//

import Foundation

struct User: Codable, Equatable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
}
