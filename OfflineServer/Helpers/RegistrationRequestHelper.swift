//
//  RegistrationRequestHelper.swift
//  OfflineServer
//
//  Created by Ian Magallan on 25/12/20.
//

import Foundation
import Combine
class RegistrationRequestHelper: RegistrationHelperProtocol {
    
    private let networkLayer: NetoworkLayerProtocol
    private let encryptionHelper: EncryptionHelperProtocol
    
    init(networkLayer: NetoworkLayerProtocol, encryptionHelper: EncryptionHelperProtocol) {
        self.networkLayer = networkLayer
        self.encryptionHelper = encryptionHelper
    }
    
    func register(_ username: String, password: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
        let url = URL(string: "https://some-api-call.com")!
        let encryptedPassword = encryptionHelper.encrypt(password)
        
        let parameters = ["username": username, "password": encryptedPassword]
        let encoder = JSONEncoder()
        let requestData = try! encoder.encode(parameters)
        
        let getUser: AnyPublisher<User, NetworkError> = networkLayer.post(url, parameters: requestData)
        
        getUser
            .sink(receiveCompletion: { receiveCompletion in
                switch receiveCompletion{
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error \(error)")
                    completion(.failure(error))
                }
            },
            receiveValue: { user in
                completion(.success(user))
            })
    }
}
