//
//  NetworkEnum.swift
//  OfflineServer
//
//  Created by Ian Magallan on 25/12/20.
//

import Foundation
enum NetworkError: Error, Equatable {
    case usernameAlreadyExists
    case unexpectedResponse
    case requestFailed
    case decodeFailed
}
