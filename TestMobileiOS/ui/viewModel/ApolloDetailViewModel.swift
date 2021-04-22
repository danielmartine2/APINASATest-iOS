//
//  ApolloDetailViewModel.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 22/04/21.
//

import Foundation

class ApolloDetailViewModel: ObservableObject {
    
    func getUrlImage(_ links: [linkImage]?) -> String{
        guard let links = links else {
            return ""
        }
        let imageData = links.filter{ $0.rel.contains("preview")}
        let urlString = imageData[0].href.replacingOccurrences(of: " ", with: "%20")
        return urlString
    }
}
