//
//  LocationsApiImp.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

import Foundation

class LocationsApiImp: LocationsApi {
    private let networkClient: ApiClient
    private let baseUrl = "https://raw.githubusercontent.com"
    
    init(networkClient: ApiClient) {
        self.networkClient = networkClient
    }
    
    func getLocations() async throws -> [Location] {
        let request = LocationsGetRequest(baseURL: baseUrl)
        
        return try await networkClient.execute(request).locations
    }
}
