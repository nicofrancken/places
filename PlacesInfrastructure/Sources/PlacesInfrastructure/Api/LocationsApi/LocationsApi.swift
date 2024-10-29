//
//  LocationsApi.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

public protocol LocationsApi {
    func getLocations() async throws -> [Location]
}
