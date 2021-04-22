//
//  ApolloViewModel.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 20/04/21.
//

import Foundation
import Combine

class ApolloViewModel: ObservableObject {
    
    @Published var apolloData: [ItemCollection] = [].self
    
    let apolloUseCase: ApolloUseCaseProtocol
    
    var cancellable: AnyCancellable? = nil
    
    init(apolloUseCase: ApolloUseCaseProtocol) {
        self.apolloUseCase = apolloUseCase
    }
    
    func getApollo() {
        cancellable?.cancel()
        cancellable = apolloUseCase.getApollo().sink{ (result) in
            switch result {
                
            case .success(let apolloData):
                self.apolloData = apolloData.items
                
            case .failure(.unknown):
                print("sin internet")
                
            default: print("")
                
            }

        }
    }
    
    func filterByKeywords(item: ItemCollection, searchText: String) -> Bool {
        let keywords = item.data[0].keywords
        for keyword in keywords {
            return keyword.uppercased().replacingOccurrences(of: " ", with: "").contains(searchText.uppercased().replacingOccurrences(of: " ", with: ""))
        }
        return false
    }
    
    
}
