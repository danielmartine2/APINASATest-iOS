//
//  apolloMock.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 21/04/21.
//

import Foundation

let jsonApollo = """
    {
      "collection": {
        "href": "http://images-api.nasa.gov/search?q=apollo%2011",
        "metadata": {
          "total_hits": 1586
        },
        "items": [
          {
            "href": "https://images-assets.nasa.gov/video/Apollo 11 Overview/collection.json",
            "links": [
              {
                "href": "https://images-assets.nasa.gov/video/Apollo 11 Overview/Apollo 11 Overview~thumb.jpg",
                "render": "image",
                "rel": "preview"
              },
              {
                "href": "https://images-assets.nasa.gov/video/Apollo 11 Overview/Apollo 11 Overview.srt",
                "rel": "captions"
              }
            ],
            "data": [
              {
                "media_type": "video",
                "center": "HQ",
                "date_created": "2013-05-15T00:00:00Z",
                "title": "Apollo 11 Overview",
                "description": "Video highlights from the historic first manned landing on the moon, during the Apollo 11 mission in July 1969.",
                "nasa_id": "Apollo 11 Overview",
                "keywords": [
                  "Apollo 11",
                  "Moon"
                ]
              }
            ]
          }
        ]
      }
    }
    """

let data = jsonApollo.data(using: .utf8)!

func getDataApollo() -> [ItemCollection]{
    let decoder = JSONDecoder()
    guard let dataApollo = try? decoder.decode(ApolloMapper.self, from: data) else {
        return []
    }
    return dataApollo.collection.items
}


