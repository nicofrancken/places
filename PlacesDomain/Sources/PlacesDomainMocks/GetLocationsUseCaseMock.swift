//
//  GetLocationsUseCaseMock.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import MockFramework

@testable import PlacesDomain

public final class GetLocationsUseCaseMock: GetLocationsUseCase {
    public let mock = GetLocationsUseCaseMockMock()

    public init(){}
    
    public func callAsFunction() async throws -> [Location] {
        return try await mock.callAsFunction()
    }
}

extension GetLocationsUseCaseMock {
    public final class GetLocationsUseCaseMockMock: GetLocationsUseCase {
        public var callAsFunctionCalls = MockAsyncThrowable<Void, [Location]>()

        public func callAsFunction() async throws -> [Location] {
            return try await callAsFunctionCalls.record(())
        }
    }
}
