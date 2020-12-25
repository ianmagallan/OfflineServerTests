//
//  RegistrationRequestHelper.swift
//  OfflineServer
//
//  Created by Ian Magallan on 25/12/20.
//

import Foundation
class RegistrationRequestHelper: RegistrationHelperProtocol {
    
    private let networkLayer: NetoworkLayerProtocol
    private let encryptionHelper: EncryptionHelperProtocol
    
    init(networkLayer: NetoworkLayerProtocol, encryptionHelper: EncryptionHelperProtocol) {
        self.networkLayer = networkLayer
        self.encryptionHelper = encryptionHelper
    }
    
    func register(_ username: String, password: String, completion: (Result<User, RegistrationRequestError>) -> Void) {
        let url = URL(string: "https://some-api-call.com")!
        let encryptedPassword = encryptionHelper.encrypt(password)
        
        let parameters = ["username": username, "password": encryptedPassword]
        let encoder = JSONEncoder()
        let requestData = try! encoder.encode(parameters)
        
        networkLayer.post(url, parameters: requestData) { (result) in
            switch result {
            case .success(let jsonData):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                if let user = try? decoder.decode(User.self, from: jsonData) {
                    completion(.success(user))
                    return
                } else if let error = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
                    if let errorCode = error["error_code"] as? String {
                        switch errorCode {
                        case "E001":
                            completion(.failure(.usernameAlreadyExists))
                            return
                        default:
                            break
                        }
                    }
                }
                
                completion(.failure(.unexpectedResponse))
            case .failure:
                completion(.failure(.requestFailed))
            }
        }
    }
}
