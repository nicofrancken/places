//
//  GetLocationsUseCase.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

import PlacesInfrastructure

public protocol GetLocationsUseCase: Sendable {
    func callAsFunction() async throws -> [Location]
}
