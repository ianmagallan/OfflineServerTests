//
//  MockNetworkLayer.swift
//  OfflineServerTests
//
//  Created by Ian Magallan on 25/12/20.
//

import Foundation
import XCTest
@testable import OfflineServer
class MockNetworkLayer: NetoworkLayerProtocol {
    var postUrl = URL(string: "testurl.com")!
    var requestData = Data()
    
    func post(_ url: URL, parameters: Data, completion: (Result<Data, Error>) -> Void) {
        postUrl = url
        requestData = parameters
        completion(.success(Data()))
    }
}
