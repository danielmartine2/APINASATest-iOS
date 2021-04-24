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
    
    @Published var isLoading = true
    @Published var withoutNetwork  = false
    
    let apolloUseCase: ApolloUseCaseProtocol
    
    var cancellable: AnyCancellable? = nil
    
    init(apolloUseCase: ApolloUseCaseProtocol) {
        self.apolloUseCase = apolloUseCase
    }
    
    func getApollo() {
        self.isLoading = true
        cancellable?.cancel()
        cancellable = apolloUseCase.getApollo().sink{ (result) in
            self.isLoading = false
            switch result {
                
            case .success(let apolloData):
                self.withoutNetwork = false
                self.apolloData = apolloData
                
            case .failure(.unknown):
                self.withoutNetwork = true
                
            default: self.withoutNetwork = false
                
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
    
    func saveIsFavourite(item: ItemCollection, arrayData: [ItemCollection]) {
        self.apolloData = apolloUseCase.saveIsFavourite(item: item, arrayData: arrayData)
        
    }
    
}
