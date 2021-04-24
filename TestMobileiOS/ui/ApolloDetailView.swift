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
    @State var showInfo: Bool = true
    
    var itemData: ItemCollection
    
    let actionButton: () -> Void
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .fill(Color.black)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading){
                
                
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
                
                
            }
            VStack{
                
                Spacer()
                
                if showInfo {
                    
                    VStack(alignment: .leading, spacing:0){
                        
                        Text(itemData.data[0].title)
                            .font(.custom("Nunito-Regular", size: 16))
                            .foregroundColor(Color(.white))
                            .padding(10)
                        
                        Divider().background(Color.gray)
                        
                        HStack{
                            Spacer()
                            Button(action: actionButton) {
                                HStack {
                                    Image(systemName: itemData.favourite ?? false  ? "star.fill" : "star")
                                        .foregroundColor(itemData.favourite ?? false ? .yellow : .white)
                                    
                                    Text("Favorito")
                                        .font(.custom("Nunito-Regular", size: 16))
                                        .fontWeight(.regular)
                                        .foregroundColor(.white)
                                    
                                }.disabled(self.isDisableButton)
                                
                            }
                            Spacer()
                            
                        }.padding(5)
                    }.background(Color.black.opacity(0.6))
                    .edgesIgnoringSafeArea(.bottom)
                    
                }
            }
        }.onTapGesture{
            withAnimation{
                self.showInfo.toggle()
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
