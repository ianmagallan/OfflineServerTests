//
//  DummyEncryptionHelper.swift
//  OfflineServerTests
//
//  Created by Ian Magallan on 25/12/20.
//

import Foundation

class DummyEncryptionHelper: EncryptionHelperProtocol {
    func encrypt(_ value: String) -> String {
        return value
    }
}
