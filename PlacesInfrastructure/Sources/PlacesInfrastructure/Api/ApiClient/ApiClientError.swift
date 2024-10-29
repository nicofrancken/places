//
//  ApiClientError.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

public enum ApiClientError: Error {
    case invalidRequest
    case responseError(error: Error, responseCode: Int?)
    case decodingError(error: Error)
    case networkError(error: Error)
}
