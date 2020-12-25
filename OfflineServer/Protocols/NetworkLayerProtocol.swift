//
//  NetworkLayerProtocol.swift
//  OfflineServer
//
//  Created by Ian Magallan on 25/12/20.
//

import Foundation
protocol NetoworkLayerProtocol {
    func post(_ url: URL, parameters: Data, completion: (Result<Data, Error>) -> Void)
}
