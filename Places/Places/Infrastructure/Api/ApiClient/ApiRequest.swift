//
//  ApiRequest.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

import Foundation

protocol ApiRequest {
    associatedtype ResponseType: Decodable
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension ApiRequest {
    func toUrl() -> URL? {
        guard let url = URL(string: baseURL),
              var urlComponents = URLComponents(url: url.appendingPathComponent(path),
                                                resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        return urlComponents.url
    }
}

enum HttpMethod: String, Equatable {
    case get
    case post
    case put
    case delete
}
