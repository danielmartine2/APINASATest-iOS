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
    
    let itemData: ItemCollection
    
    var body: some View {
        VStack{
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
            
            Text(itemData.data[0].title)
        }
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
        ItemApolloView(itemData: itemData).previewLayout(.fixed(width: .infinity, height: 300))
    }
}
