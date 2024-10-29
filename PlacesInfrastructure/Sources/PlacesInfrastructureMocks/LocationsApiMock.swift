//
//  LocationsApiMock.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import MockFramework

@testable import PlacesInfrastructure

public final class LocationsApiMock: LocationsApi {
    public let mock = LocationsApiMockMock()

    public init(){}
    
    public func getLocations() async throws -> [Location] {
        return try await mock.getLocationsCalls.record(())
    }
}

extension LocationsApiMock {
    public final class LocationsApiMockMock {
        public var getLocationsCalls = MockAsyncThrowable<Void, [Location]>()

        func getLocations() async throws -> [Location] {
            return try await getLocationsCalls.record(())
        }
    }
}
