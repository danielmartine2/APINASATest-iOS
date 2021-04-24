//
//  ApolloViewModelTest.swift
//  TestMobileiOSTests
//
//  Created by Citixen MacBook on 24/04/21.
//

import Foundation
import XCTest
import Combine
@testable import TestMobileiOS

class ApolloViewModelTest: XCTestCase {
    
    var apolloUseCase: ApolloUseCaseMock!
    
    override func setUp() {
        apolloUseCase = ApolloUseCaseMock()
    }
    
    func testSuccessFetchData() {
        
        let apolloData = getDataApollo()
        
        
        let response = PassthroughSubject<Result<[ItemCollection], NetworkError>, Never>()
        
        apolloUseCase.stubbedFerchApolloDataResult = response.eraseToAnyPublisher()
        
        let apolloViewModel = ApolloViewModel(apolloUseCase: apolloUseCase)
        
        let exp = expectValue(of: response.eraseToAnyPublisher(), equals: [{ output -> Bool in
            
            switch output {
                case .success(let successApolloData):
                    return successApolloData[0].id == apolloData[0].id
            case .failure(_): return false
            }
        }])
        
        apolloViewModel.getApollo()
        
        response.send(.success(apolloData))
        
        wait(for: [exp.expectation], timeout: 1)
    }
    
}
