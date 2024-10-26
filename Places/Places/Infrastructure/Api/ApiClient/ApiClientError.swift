//
//  ApiClientError.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

enum ApiClientError: Error {
    case invalidRequest
    case networkError(Error)
    case noData
    case decodingError(Error)
}
