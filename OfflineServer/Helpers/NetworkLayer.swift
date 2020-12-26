//
//  NetworkLayer.swift
//  OfflineServer
//
//  Created by Ian Magallan on 25/12/20.
//

import Foundation
import Combine
class NetworkLayer: NetoworkLayerProtocol {
    func post<T>(_ url: URL, parameters: Data) -> AnyPublisher<T, NetworkError> {
        // Something
        return Fail(error: NetworkError.unexpectedResponse)
            .eraseToAnyPublisher()
    }
}
