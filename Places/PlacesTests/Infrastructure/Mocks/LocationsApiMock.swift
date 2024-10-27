//
//  LocationsApiMock.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import MockFramework

@testable import Places

final class LocationsApiMock: LocationsApi {
    let mock = LocationsApiMockMock()

    func getLocations() async throws -> [Location] {
        return try await mock.getLocationsCalls.record(())
    }
}

extension LocationsApiMock {
    final class LocationsApiMockMock {
        var getLocationsCalls = MockAsyncThrowable<Void, [Location]>()

        func getLocations() async throws -> [Location] {
            return try await getLocationsCalls.record(())
        }
    }
}
