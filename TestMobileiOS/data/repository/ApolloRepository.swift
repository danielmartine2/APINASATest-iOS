//
//  ApolloRepository.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 20/04/21.
//

import Foundation
import Combine

protocol ApolloRepositoryProtocol {
    func getApollo() -> AnyPublisher<Result<[ItemCollection],NetworkError>,Never>
    func saveIsFavourite(item: ItemCollection, arrayData: [ItemCollection]) -> [ItemCollection]
}

class ApolloRepository: ApolloRepositoryProtocol {
    
    let apolloApi: ApolloApiProtocol
    let localStorage: LocalStorageProtocol
    
    init(apolloApi: ApolloApiProtocol, localStorage: LocalStorageProtocol) {
        self.apolloApi = apolloApi
        self.localStorage = localStorage
    }
    
    func getApollo() -> AnyPublisher<Result<[ItemCollection], NetworkError>, Never> {
        
        
        let jsonDataApollo = localStorage.getApolloData()
        let decoder = JSONDecoder()
        
        guard jsonDataApollo != nil,  let dataApollo = try? decoder.decode([ItemCollection].self, from: jsonDataApollo!) else {
            
            return apolloApi.requestApollo().map({result in
                
                switch result {
                
                case .success(let apollo):
                    
                    let encode = try? JSONEncoder().encode(apollo)
                    self.localStorage.saveApolloData(value: encode)
                    return .success(apollo)
                    
                case .failure(let message): return .failure(message)
                    
                }
                
            })
            .eraseToAnyPublisher()
        }
        
        return .just(.success(dataApollo))
    }
    
    
    func saveIsFavourite(item: ItemCollection, arrayData: [ItemCollection]) -> [ItemCollection] {
        
        let result = arrayData.map{ element -> ItemCollection in
            var itemData = element
            if element.id == item.id {
                itemData.favourite = item.favourite  == true ?  false : true
            }
            return itemData
        }
    
        
        let encoder = JSONEncoder()
        guard let saveData = try? encoder.encode(result) else {
            return result
        }
        
        localStorage.saveApolloData(value: saveData)
        return result
    }
}

