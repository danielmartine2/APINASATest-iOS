//
//  LocalStorageProtocol.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 22/04/21.
//

import Foundation

protocol LocalStorageProtocol {
    func saveApolloData(value: Data?)
    func getApolloData() -> Data?
}

class LocalStorage: LocalStorageProtocol {
    
    let ApolloData = "apollo_data"
    
    func saveApolloData(value: Data?) {
        UserDefaults.standard.set(value, forKey: ApolloData)
    }
    
    func getApolloData() -> Data? {
        return UserDefaults.standard.data(forKey: ApolloData)
    }
}
