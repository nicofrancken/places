//
//  LocationRepositoryMock.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import MockFramework

@testable import Places

final class LocationsRepositoryMock: LocationsRepository {
    let mock = LocationsRepositoryMockMock()

    func getAllLocations() async throws -> [Location] {
        return try await mock.getAllLocations()
    }
}

extension LocationsRepositoryMock {
    final class LocationsRepositoryMockMock {
        var getAllLocationsCalls = MockAsyncThrowable<Void, [Location]>()

        func getAllLocations() async throws -> [Location] {
            return try await getAllLocationsCalls.record(())
        }
    }
}
