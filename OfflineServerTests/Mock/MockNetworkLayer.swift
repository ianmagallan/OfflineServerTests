//
//  MockNetworkLayer.swift
//  OfflineServerTests
//
//  Created by Ian Magallan on 25/12/20.
//

import Foundation
import Combine
import XCTest
@testable import OfflineServer
class MockNetworkLayer: NetoworkLayerProtocol {
    func post<T: Decodable>(_ url: URL, parameters: Data) -> AnyPublisher<T, NetworkError> {
        postUrl = url
        requestData = parameters
        return Just(Data())
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError{ _ in NetworkError.requestFailed }
            .eraseToAnyPublisher()
    }
    
    var postUrl = URL(string: "testurl.com")!
    var requestData = Data()
    
    func post(_ url: URL, parameters: Data, completion: (Result<Data, Error>) -> Void) {

        completion(.success(Data()))
    }
}
