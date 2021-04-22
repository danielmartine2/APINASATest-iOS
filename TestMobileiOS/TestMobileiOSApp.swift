//
//  TestMobileiOSApp.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 20/04/21.
//

import SwiftUI
import Swinject

@main
struct TestMobileiOSApp: App {
    
    let loginViewModel: ApolloViewModel
    
    init() {
        loginViewModel = Assembler.sharedAssembly.resolver.resolve(ApolloViewModel.self)!
    }
    
    var body: some Scene {
        WindowGroup {
            ApolloView().environmentObject(loginViewModel)
        }
        
    }
}
