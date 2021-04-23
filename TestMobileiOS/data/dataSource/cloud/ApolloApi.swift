//
//  ApolloApi.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 20/04/21.
//

import Foundation
import Combine

protocol ApolloApiProtocol {
    func requestApollo() -> AnyPublisher<Result<[ItemCollection], NetworkError>, Never>
    func makeResource() -> URLRequest
}

class ApolloApi: ApolloApiProtocol {
    
    private let client: Client
    private let url: String
    
    init(client: Client, url: String) {
        self.client = client
        self.url = url
    }
    
    func requestApollo() -> AnyPublisher<Result<[ItemCollection], NetworkError>, Never> {
        
        return client.run(makeResource()).map { data, response -> Result<[ItemCollection], NetworkError> in
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.jsonDecodingError)
            }
            
            switch(response.statusCode){
                  
            case 200..<300:
                let decoder = JSONDecoder()
                let apolloData: ApolloMapper
                do {
                    apolloData = try decoder.decode(ApolloMapper.self, from: data)
                }catch{
                    print(error)
                    return .failure(.jsonDecodingError)
                }
                
                return .success(apolloData.collection.items)
                
            case 401: return .failure(.unAuthorized)
                
            case 400..<500:
                return .failure(.badRequest(message: "Bad Request"))
                
            default:
                return .failure(NetworkError.invalidResponse)
            }
        }
        .catch { error -> AnyPublisher<Result<[ItemCollection], NetworkError>, Never> in
            return .just(.failure(NetworkError.unknown))
        }
        .eraseToAnyPublisher()
    
    }
    
    func makeResource() -> URLRequest {
        return client.makeUrlRequest(urlString: self.url, httpMethod: .get)!
    }
    
    
}
