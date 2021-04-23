//
//  ApolloDeatailUseCase.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 22/04/21.
//

import Foundation

protocol ApolloDetailUseCaseProtocol {
    
    func saveIsFavourite(isFavourite: Bool, id: String) -> Bool
    
}

class ApolloDetailUseCase: ApolloDetailUseCaseProtocol {
    
    let apolloDetailRepository: ApolloDetailRepositoryProtocol
    
    init(apolloDetailRepository: ApolloDetailRepositoryProtocol) {
        self.apolloDetailRepository = apolloDetailRepository
    }
    
    func saveIsFavourite(isFavourite: Bool, id: String) -> Bool {
        return apolloDetailRepository.saveIsFavourite(isFavourite: isFavourite, id: id)
    }
    
}
