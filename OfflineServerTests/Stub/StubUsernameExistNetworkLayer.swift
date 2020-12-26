//
//  StubUsernameExistNetworkLayer.swift
//  OfflineServerTests
//
//  Created by Ian Magallan on 26/12/20.
//

import Foundation
import Combine
class StubUsernameExistNetworkLayer: NetoworkLayerProtocol {
    func post<T: Decodable>(_ url: URL, parameters: Data) -> AnyPublisher<T, NetworkError> {
        let responseJSON = """
            {
                "error_code": "E001",
                "message": "Username already exists"
            }
        """
        
        let fakeResponse = HTTPURLResponse(url: url, statusCode: 400, httpVersion: "HTTP/1.1", headerFields: nil)!
        let jsonData = Data(responseJSON.utf8)
        
        return Just((data: jsonData, response: fakeResponse))
            .tryMap { data, response in
                if let response = response as? HTTPURLResponse, response.statusCode == 400 {
                    throw NetworkError.usernameAlreadyExists
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                error as! NetworkError
            }
            .eraseToAnyPublisher()
    }
}
