//
//  MainAssembly.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 21/04/21.
//

import Foundation
import Swinject

extension Assembler {
    
    static let sharedAssembly: Assembler = {
        
        let container = Container()
        let assembler = Assembler([
            ApolloAssembly(),
            ApolloDetailAssembly()
        ],container: container)
        
        return assembler
        
    }()
    
    
}
