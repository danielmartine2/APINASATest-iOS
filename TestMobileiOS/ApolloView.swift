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
    
    @State private var searchText: String = ""
    
    var body: some View {
            
        NavigationView {
            
            ZStack{
                
                Rectangle()
                    .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                    .edgesIgnoringSafeArea(.all)
                
                Rectangle()
                    .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                    .rotationEffect(Angle(degrees: 45))
                    .edgesIgnoringSafeArea(.all)

                
                VStack {
                    
                    SearchBarView(text: $searchText).padding()
                    
                    List{
                    ForEach(self.apolloViewModel.apolloData.filter({ searchText.isEmpty ? true : self.apolloViewModel.filterByKeywords(item: $0, searchText: searchText) })){ item in
                        
                        NavigationLink(destination: ApolloDetailView(itemData: item)){
                            ItemApolloView(itemData: item)
                        }
                        
                    }
                    }.onAppear{
                        self.apolloViewModel.getApollo()
                    }
                    
                }
                
                .navigationBarTitle("NASA Api")
            }
        }.environmentObject(ApolloDetailViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ApolloView().environmentObject(Assembler.sharedAssembly.resolver.resolve(ApolloViewModel.self)!)
    }
}
