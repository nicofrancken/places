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
    func toURLRequest() -> URLRequest? {
        guard let url = URL(string: baseURL),
              var urlComponents = URLComponents(url: url.appendingPathComponent(path),
                                                resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        if method == .get, let parameters = parameters as? [String: String] {
            urlComponents.queryItems = parameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if method != .get, let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        return request
    }
}

enum HttpMethod: String {
    case get
    case post
    case put
    case delete
}
