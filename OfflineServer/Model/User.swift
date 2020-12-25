//
//  User.swift
//  OfflineServer
//
//  Created by Ian Magallan on 25/12/20.
//

import Foundation
struct User: Decodable {
    let userId: Int
    let username: String
    let email: String? = nil
    let phone: String? = nil
}
