//
//  LocationsApi.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

protocol LocationsApi {
    func getLocations() async throws -> [Location]
}
