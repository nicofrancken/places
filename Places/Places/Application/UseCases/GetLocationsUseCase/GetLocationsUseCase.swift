//
//  GetLocationsUseCase.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

protocol GetLocationsUseCase {
    func callAsFunction() async throws -> [Location]
}
