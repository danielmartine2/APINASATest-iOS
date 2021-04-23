//
//  ContentView.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 20/04/21.
//

import SwiftUI
import Swinject

struct ApolloView: View {
    
    @EnvironmentObject private var apolloViewModel: ApolloViewModel
    
    @Environment(\.scenePhase) var scenePhase
    
    @State private var searchText: String = ""

    @State private var isFavorite: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack{
                
                
                VStack {
                    
                    SearchBarView(text: $searchText).padding()
                    
                    ScrollView{
                        ForEach(self.apolloViewModel.apolloData.filter({ searchText.isEmpty ? true : self.apolloViewModel.filterByKeywords(item: $0, searchText: searchText) }), id: \.id){ item in
                            
                            
                                ItemApolloView(itemData: item, actionFavourite: {
                                    self.apolloViewModel.saveIsFavourite(item: item, arrayData: self.apolloViewModel.apolloData)
                                })
                          
                        }
                    }
                    
                }
                
            }
            
            .navigationBarTitle("NASA Api", displayMode: .inline)
            .buttonStyle(PlainButtonStyle())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear{
            self.apolloViewModel.getApollo()
        }
        
        .environmentObject(ApolloDetailViewModel()
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ApolloView().environmentObject(Assembler.sharedAssembly.resolver.resolve(ApolloViewModel.self)!)
    }
}
