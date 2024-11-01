//
//  LocationsApiImp.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

import Foundation

public class LocationsApiImp: LocationsApi {
    private let apiClient: ApiClient
    private let baseUrl = "https://raw.githubusercontent.com"
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    public func getLocations() async throws -> [LocationDTO] {
        let request = LocationsGetRequest(baseURL: baseUrl)
        
        do {
            let locations = try await apiClient.execute(request).locations
            
            return locations
        } catch {
            throw LocationsApiError.errorRetrievingLocations(error: error)
        }
    }
}
