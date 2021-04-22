//
//  ApolloUseCase.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 20/04/21.
//

import Foundation
import Combine

protocol ApolloUseCaseProtocol {
    func getApollo() -> AnyPublisher<Result<Collection, NetworkError>,Never>
}

class ApolloUseCase: ApolloUseCaseProtocol {
    
    let apolloRepository: ApolloRepositoryProtocol
    
    init(apolloRepository: ApolloRepositoryProtocol) {
        self.apolloRepository = apolloRepository
    }
    
    
    func getApollo() -> AnyPublisher<Result<Collection, NetworkError>, Never> {
        return apolloRepository.getApollo().map({result in
        
                switch result {
                    
                case .success(let apollo): return .success(apollo)
                    
                case .failure(let message): return .failure(message)
                    
                }
        
            })
            
            .eraseToAnyPublisher()
    }
    
    
}
