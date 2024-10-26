//
//  LocationsRepository.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

protocol LocationsRepository {
    func getAllLocations() async throws -> [Location]
}
