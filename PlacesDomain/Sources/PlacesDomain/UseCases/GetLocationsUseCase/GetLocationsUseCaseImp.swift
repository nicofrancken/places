//
//  GetLocationsUseCaseImp.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

import PlacesInfrastructure

public class GetLocationsUseCaseImp: GetLocationsUseCase {
    private let locationsRepository: LocationsRepository
    
    public init(locationsRepository: LocationsRepository) {
        self.locationsRepository = locationsRepository
    }

    public func callAsFunction() async throws -> [Location] {
        try await locationsRepository.getAllLocations()
    }
}