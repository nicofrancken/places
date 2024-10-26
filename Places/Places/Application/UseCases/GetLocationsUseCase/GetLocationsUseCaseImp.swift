//
//  GetLocationsUseCaseImp.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

class GetLocationsUseCaseImp: GetLocationsUseCase {
    private let locationsRepository: LocationsRepository
    
    init(locationsRepository: LocationsRepository) {
        self.locationsRepository = locationsRepository
    }

    func callAsFunction() async throws -> [Location] {
        try await locationsRepository.getAllLocations()
    }
}
