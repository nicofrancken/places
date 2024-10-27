//
//  ApiClientFactory.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

final class ApiClientFactory {
    static let shared = ApiClientFactory()
    
    private init() {}
    
    func getInstance() -> ApiClient {
        ApiClientImp()
    }
}
