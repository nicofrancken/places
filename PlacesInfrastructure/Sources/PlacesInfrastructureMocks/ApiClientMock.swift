//
//  ApiClientMock.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import MockFramework

@testable import PlacesInfrastructure

public final class ApiClientMock: ApiClient {
    let mock = ApiClientMockMock()

    public func execute<T: ApiRequest>(_ request: T) async throws -> T.ResponseType {
        return try await mock.execute(request)
    }
}

extension ApiClientMock {
    final class ApiClientMockMock {
        var executeCalls = MockAsyncThrowable<(any ApiRequest), Any>()

        func execute<T: ApiRequest>(_ request: T) async throws -> T.ResponseType {
            return try await executeCalls.record(request) as! T.ResponseType
        }
    }
}
