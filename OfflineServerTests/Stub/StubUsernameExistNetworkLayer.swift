//
//  StubUsernameExistNetworkLayer.swift
//  OfflineServerTests
//
//  Created by Ian Magallan on 26/12/20.
//

import Foundation
class StubUsernameExistNetworkLayer: NetoworkLayerProtocol {
    func post(_ url: URL, parameters: Data, completion: (Result<Data, Error>) -> Void) {
        let responseJSON = """
            {
                "error_code": "E001",
                "message": "Username already exists"
            }
        """
        
        let jsonData = Data(responseJSON.utf8)
        completion(.success(jsonData))
    }
}
