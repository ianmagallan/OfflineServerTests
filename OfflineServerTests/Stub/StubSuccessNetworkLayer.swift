//
//  StubSuccessNetworkLayer.swift
//  OfflineServerTests
//
//  Created by Ian Magallan on 25/12/20.
//

import Foundation
class StubSuccessNetworkLayer: NetoworkLayerProtocol {
    func post(_ url: URL, parameters: Data, completion: (Result<Data, Error>) -> Void) {
        let responseJson = """
            {
                "user_id": 1001,
                "username": "john",
                "email": null,
                "phone": null
            }
        """
        
        let jsonData = Data(responseJson.utf8)
        completion(.success(jsonData))
    }
}
