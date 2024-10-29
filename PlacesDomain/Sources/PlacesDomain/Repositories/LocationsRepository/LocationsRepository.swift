//
//  LocationsRepository.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

import PlacesInfrastructure

public protocol LocationsRepository {
    func getAllLocations() async throws -> [Location]
}
