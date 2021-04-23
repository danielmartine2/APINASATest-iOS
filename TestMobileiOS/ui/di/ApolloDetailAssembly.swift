//
//  ApolloDetailAssembly.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 22/04/21.
//

import Foundation

import Swinject

class ApolloDetailAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(ApolloDetailViewModel.self) { (resolver) -> ApolloDetailViewModel in
            ApolloDetailViewModel()
        }
    }
}
