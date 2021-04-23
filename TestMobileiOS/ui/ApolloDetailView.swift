//
//  ApolloDetailView.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 20/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ApolloDetailView: View {
    
    @EnvironmentObject private var apolloDetailViewModel: ApolloDetailViewModel
    
    @State private var isDisableButton: Bool = false

    var itemData: ItemCollection
    
    let actionButton: () -> Void
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading){
                
                Spacer()
                
                Text(itemData.data[0].title)
                
                WebImage(url: URL(string: self.apolloDetailViewModel.getUrlImage(itemData.links )))
                    .onSuccess { image, data, cacheType in
                        // Success
                    }
                    .resizable()
                    .placeholder {
                        Rectangle().foregroundColor(.gray)
                    }
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                HStack{
                    Spacer()
                    Button(action: actionButton) {
                        HStack {
                            Image(systemName: itemData.favourite ?? false  ? "star.fill" : "star")
                                .font(.title)
                                .foregroundColor(itemData.favourite ?? false ? .yellow : .white)
                            Text("Favorito")
                                .fontWeight(.regular)
                                .font(.title)
                                .foregroundColor(.white)
                        }.disabled(self.isDisableButton)
                        .padding()
                       
                    }
                    Spacer()
                }.background(Color.black.opacity(0.8))
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

struct ApolloDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let itemData = getDataApollo()[0]
        ApolloDetailView(itemData: itemData, actionButton: {})
    }
}
