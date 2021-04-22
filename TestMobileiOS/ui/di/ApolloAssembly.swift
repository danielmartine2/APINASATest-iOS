//
//  ApolloAssembly.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 21/04/21.
//

import Foundation
import Swinject

class ApolloAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(Client.self) { (resolver) -> Client in
            Client()
        }
        
        container.register(LocalStorageProtocol.self) { (rsolver) -> LocalStorage in
            LocalStorage()
        }
        
        container.register(ApolloApiProtocol.self){ (resolver) -> ApolloApi in
            ApolloApi(client: resolver.resolve(Client.self)!, url: EndPoints.apollo11)
        }
        
        container.register(ApolloRepositoryProtocol.self){ resolver -> ApolloRepository in
            ApolloRepository(apolloApi: resolver.resolve(ApolloApiProtocol.self)!, localStorage: resolver.resolve(LocalStorageProtocol.self)!)
        }
        
        container.register(ApolloUseCaseProtocol.self) { (resolver) -> ApolloUseCase in
            ApolloUseCase(apolloRepository: resolver.resolve(ApolloRepositoryProtocol.self)!)
        }
        
        container.register(ApolloViewModel.self) { (resolver) -> ApolloViewModel in
            ApolloViewModel(apolloUseCase: resolver.resolve(ApolloUseCaseProtocol.self)!)
        }
    }
}
