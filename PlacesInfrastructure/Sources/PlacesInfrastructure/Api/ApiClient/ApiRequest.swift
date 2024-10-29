//
//  ApiRequest.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

import Foundation

public protocol ApiRequest {
    associatedtype ResponseType: Decodable & Sendable
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var parameters: [String: String]? { get }
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

public enum HttpMethod: String, Equatable, Sendable {
    case get
    case post
    case put
    case delete
}
