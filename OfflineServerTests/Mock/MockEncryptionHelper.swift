//
//  MockEncryptionHelper.swift
//  OfflineServerTests
//
//  Created by Ian Magallan on 25/12/20.
//

import Foundation
@testable import OfflineServer
class MockEncryptionHelper: EncryptionHelperProtocol {
    var encryptionCalled = false
    
    func encrypt(_ value: String) -> String {
        encryptionCalled = true
        return "1234567890"
    }
}
