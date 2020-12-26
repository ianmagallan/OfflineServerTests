//
//  RegistrationHelperProtocol.swift
//  OfflineServer
//
//  Created by Ian Magallan on 25/12/20.
//

import Foundation
protocol RegistrationHelperProtocol {
    func register(_ username: String,
                  password: String,
                  completion: @escaping (Result<User, NetworkError>) -> Void)
}
