//
//  LocationRepositoryMock.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import MockFramework

@testable import PlacesDomain

public final class LocationsRepositoryMock: LocationsRepository {
    public let mock = LocationsRepositoryMockMock()

    public func getAllLocations() async throws -> [Location] {
        return try await mock.getAllLocations()
    }
}

extension LocationsRepositoryMock {
    public final class LocationsRepositoryMockMock {
        public var getAllLocationsCalls = MockAsyncThrowable<Void, [Location]>()

        public func getAllLocations() async throws -> [Location] {
            return try await getAllLocationsCalls.record(())
        }
    }
}
