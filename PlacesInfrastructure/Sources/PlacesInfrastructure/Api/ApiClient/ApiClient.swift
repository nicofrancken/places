//
//  ApiClient.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

public protocol ApiClient {
    func execute<T : ApiRequest>(_ request: T) async throws -> T.ResponseType
}
