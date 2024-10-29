//
//  ApiClientFactory.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

public final class ApiClientFactory: Sendable {
    static let shared = ApiClientFactory()
    
    private init() {}
    
    public func getInstance() -> ApiClient {
        ApiClientImp()
    }
}
