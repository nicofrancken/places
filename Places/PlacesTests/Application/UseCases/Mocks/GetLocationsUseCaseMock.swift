//
//  GetLocationsUseCaseMock.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import MockFramework

@testable import Places

final class GetLocationsUseCaseMock: GetLocationsUseCase {
    let mock = GetLocationsUseCaseMockMock()

    func callAsFunction() async throws -> [Location] {
        return try await mock.callAsFunction()
    }
}

extension GetLocationsUseCaseMock {
    final class GetLocationsUseCaseMockMock: GetLocationsUseCase {
        var callAsFunctionCalls = MockAsyncThrowable<Void, [Location]>()

        func callAsFunction() async throws -> [Location] {
            return try await callAsFunctionCalls.record(())
        }
    }
}
