//
//  ApiClientImp.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

import Foundation

class ApiClientImp: ApiClient {
    let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func execute<T : ApiRequest>(_ request: T) async throws -> T.ResponseType {
        guard let urlRequest = request.toURLRequest() else {
            throw ApiClientError.invalidRequest
        }
        
        do {
            let (data, _) = try await urlSession.data(for: urlRequest)

            do {
                return try JSONDecoder().decode(T.ResponseType.self,
                                                from: data)
            } catch {
                throw ApiClientError.decodingError(error)
            }
        } catch {
            throw ApiClientError.networkError(error)
        }
    }
}
