//
//  ItemApolloView.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 20/04/21.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct ItemApolloView: View {
    
    @EnvironmentObject private var apolloViewModel: ApolloViewModel
    let itemData: ItemCollection
    let actionFavourite: () -> Void
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0){
            ZStack(alignment: .top){
                NavigationLink(destination: ApolloDetailView(itemData: itemData, actionButton: {
                    self.apolloViewModel.saveIsFavourite(item: itemData, arrayData: self.apolloViewModel.apolloData)
                })){
                WebImage(url: URL(string: getUrlImage(itemData.links)))
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
                HStack{
                    Spacer()
                    Button(action: actionFavourite, label: {
                        
                        Image(systemName: itemData.favourite == true ? "star.fill" : "star")
                            .font(.title)
                            .foregroundColor(itemData.favourite == true ? .yellow : .white)
                            .padding(10)
                        
                    }).background(Color.gray.opacity(0.5))
                    .clipShape(Circle())
                    .padding(10)
                }
            }
            
            Text(itemData.data[0].title).padding(.all, 10)
            
        }.background(Color.gray.opacity(0.5))
    }
    
    private func getUrlImage(_ links: [linkImage]?) -> String{
        guard let links = links else {
            return ""
        }
        let imageData = links.filter{ $0.rel.contains("preview")}
        let urlString = imageData[0].href.replacingOccurrences(of: " ", with: "%20")
        return urlString
    }
}

struct ItemApolloView_Previews: PreviewProvider {
    static var previews: some View {
        let itemData = getDataApollo()[0]
        ItemApolloView(itemData: itemData, actionFavourite: {}).previewLayout(.fixed(width: .infinity, height: 300))
    }
}
