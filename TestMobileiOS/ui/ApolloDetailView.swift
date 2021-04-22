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
    
    var itemData: ItemCollection
    
    var body: some View {
        ZStack {
            VStack{
                
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
                
                HStack{
                    Spacer()
                    Button(action: {
                        print("Delete tapped!")
                    }) {
                        HStack {
                            Image(systemName: "star")
                                .font(.title)
                            Text("Favorito")
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                    }
                }
            }
        }
    }
}

struct ApolloDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let itemData = getDataApollo()[0]
        ApolloDetailView(itemData: itemData)
    }
}
