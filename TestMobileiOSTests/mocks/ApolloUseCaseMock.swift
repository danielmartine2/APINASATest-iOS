//
//  ApolloUseCaseMock.swift
//  TestMobileiOSTests
//
//  Created by Citixen MacBook on 24/04/21.
//

import Foundation
import Combine
@testable import TestMobileiOS


class ApolloUseCaseMock: ApolloUseCaseProtocol {
    
    var invokedFetchApolloData = false
    var invokedFetchApolloDataCount = 0
    var stubbedFerchApolloDataResult: AnyPublisher<Result<[ItemCollection], NetworkError>, Never>!
    
    func getApollo() -> AnyPublisher<Result<[ItemCollection], NetworkError>, Never> {
        invokedFetchApolloData = true
        invokedFetchApolloDataCount += 1
        return stubbedFerchApolloDataResult
    }
    
    func saveIsFavourite(item: ItemCollection, arrayData: [ItemCollection]) -> [ItemCollection] {
        return getDataApollo()
    }
    
}
