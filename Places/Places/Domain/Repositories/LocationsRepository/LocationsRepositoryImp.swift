//
//  LocationsRepositoryImp.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

class LocationsRepositoryImp: LocationsRepository {
    private let locationsApi: LocationsApi
    
    init(locationsApi: LocationsApi) {
        self.locationsApi = locationsApi
    }
    
    func getAllLocations() async throws -> [Location] {
        try await locationsApi.getLocations()
    }
}
