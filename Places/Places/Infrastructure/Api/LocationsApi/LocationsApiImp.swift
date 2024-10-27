//
//  LocationsApiImp.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

import Foundation

class LocationsApiImp: LocationsApi {
    private let apiClient: ApiClient
    private let baseUrl = "https://raw.githubusercontent.com"
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func getLocations() async throws -> [Location] {
        let request = LocationsGetRequest(baseURL: baseUrl)
        
        do {
            let locations = try await apiClient.execute(request).locations
            
            return locations
        } catch {
            throw LocationsApiError.errorRetrievingLocations(error: error)
        }
    }
}
