//
//  ApolloRepository.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 20/04/21.
//

import Foundation
import Combine

protocol ApolloRepositoryProtocol {
    func getApollo() -> AnyPublisher<Result<Collection,NetworkError>,Never>
}

class ApolloRepository: ApolloRepositoryProtocol {
    
    let apolloApi: ApolloApiProtocol
    let localStorage: LocalStorageProtocol
    
    init(apolloApi: ApolloApiProtocol, localStorage: LocalStorageProtocol) {
        self.apolloApi = apolloApi
        self.localStorage = localStorage
    }
    
    func getApollo() -> AnyPublisher<Result<Collection, NetworkError>, Never> {
        
        
        let jsonDataApollo = localStorage.getApolloData()
        let decoder = JSONDecoder()
        guard jsonDataApollo != nil,  let dataApollo = try? decoder.decode(Collection.self, from: jsonDataApollo!) else {
            
            return apolloApi.requestApollo().map({result in
                
                switch result {
                
                case .success(let apollo):
                    
                    let encoded = try? JSONEncoder().encode(apollo)
                    self.localStorage.saveApolloData(value: encoded)
                    return .success(apollo)
                    
                case .failure(let message): return .failure(message)
                    
                }
                
            })
            .eraseToAnyPublisher()
        }
        
        return .just(.success(dataApollo))
    }
}

