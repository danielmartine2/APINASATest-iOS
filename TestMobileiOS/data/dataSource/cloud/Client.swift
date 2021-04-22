//
//  Client.swift
//  TestMobileiOS
//
//  Created by Citixen MacBook on 20/04/21.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case dataLoadingError(statusCode: Int, data: Data)
    case jsonDecodingError
    case badRequest(message: String)
    case unAuthorized
    case unknown
}

public struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    public static let get = HTTPMethod(rawValue: "GET")
    
    public let rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

protocol ClientProtocol {
    func makeUrlRequest(urlString: String, httpMethod: HTTPMethod)-> URLRequest?
    func run(_ requets: URLRequest) -> URLSession.DataTaskPublisher
}

struct Client: ClientProtocol {
    
    func run(_ requets: URLRequest) -> URLSession.DataTaskPublisher {
        
        return  URLSession.shared
            .dataTaskPublisher(for: requets)
        
    }
    
    func makeUrlRequest(urlString: String,httpMethod: HTTPMethod)-> URLRequest? {
        
        guard let url =  URL(string: urlString) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return urlRequest
        
    }
    
}

extension Publisher {
    
    static func empty() -> AnyPublisher<Output, Failure> {
        return Empty().eraseToAnyPublisher()
    }
    
    static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
        return Just(output)
            .catch { _ in AnyPublisher<Output, Failure>.empty() }
            .eraseToAnyPublisher()
    }
    
}

