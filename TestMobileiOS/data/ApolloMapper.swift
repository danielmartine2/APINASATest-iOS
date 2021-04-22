//
//  ApolloMapper.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 20/04/21.
//

import Foundation

struct ApolloMapper: Codable {
    let collection: Collection
}

struct Collection: Codable{
    let items: [ItemCollection]
}

struct ItemCollection: Codable, Identifiable {
    var id = UUID()
    let data: [ApolloData]
    let links: [linkImage]?
    
    enum CodingKeys: String, CodingKey {
        case data, links
    }
}

struct ApolloData: Codable {
    let title: String
    let keywords: [String]
    let description: String
    let nasa_id: String
}

struct linkImage: Codable {
    let href: String
    let rel: String
}





