//
//  NetworkLayerProtocol.swift
//  OfflineServer
//
//  Created by Ian Magallan on 25/12/20.
//

import Foundation
import Combine
protocol NetoworkLayerProtocol {
    func post<T: Decodable>(_ url: URL, parameters: Data) -> AnyPublisher<T, NetworkError>
}
