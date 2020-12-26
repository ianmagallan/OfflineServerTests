//
//  StubSuccessNetworkLayer.swift
//  OfflineServerTests
//
//  Created by Ian Magallan on 25/12/20.
//

import Foundation
import Combine
class StubSuccessNetworkLayer: NetoworkLayerProtocol {
    func post<T: Decodable>(_ url: URL, parameters: Data) -> AnyPublisher<T, NetworkError> {
        let responseJson = """
            {
                "user_id": 1001,
                "username": "john",
                "email": null,
                "phone": null
            }
        """
        
        let jsonData = Data(responseJson.utf8)
        
        return Just(jsonData)
            .tryMap { data in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                if let decodedData = try? decoder.decode(T.self, from: data) {
                    return decodedData
                }
                
                throw NetworkError.decodeFailed
            }
            .mapError { $0 as! NetworkError }
            .eraseToAnyPublisher()
    }
}
