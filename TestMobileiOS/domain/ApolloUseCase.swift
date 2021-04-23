//
//  ApolloUseCase.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 20/04/21.
//

import Foundation
import Combine

protocol ApolloUseCaseProtocol {
    func getApollo() -> AnyPublisher<Result< [ItemCollection], NetworkError>,Never>
    func saveIsFavourite(item: ItemCollection, arrayData: [ItemCollection]) -> [ItemCollection]
}

class ApolloUseCase: ApolloUseCaseProtocol {
    
    let apolloRepository: ApolloRepositoryProtocol
    
    init(apolloRepository: ApolloRepositoryProtocol) {
        self.apolloRepository = apolloRepository
    }
    
    
    func getApollo() -> AnyPublisher<Result<[ItemCollection], NetworkError>, Never> {
        return apolloRepository.getApollo().map({result in
            
            switch result {
            
            case .success(let apollo): return .success(apollo)
                
            case .failure(let message): return .failure(message)
                
            }
            
        })
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    func saveIsFavourite(item: ItemCollection, arrayData: [ItemCollection]) -> [ItemCollection]{
        return apolloRepository.saveIsFavourite(item: item, arrayData: arrayData)
    }
    
    
}
