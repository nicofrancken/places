//
//  LocationsRepositoryImp.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

import PlacesInfrastructure

public class LocationsRepositoryImp: LocationsRepository {
    private let locationsApi: LocationsApi
    
    public init(locationsApi: LocationsApi) {
        self.locationsApi = locationsApi
    }
    
    public func getAllLocations() async throws -> [Location] {
        try await locationsApi.getLocations()
    }
}
