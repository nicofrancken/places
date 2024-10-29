//
//  LaunchWikipediaWithCoordinatesUseCaseMock.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import MockFramework

@testable import PlacesDomain

public final class LaunchWikipediaWithCoordinatesUseCaseMock: LaunchWikipediaWithCoordinatesUseCase {
    public let mock = LaunchWikipediaWithCoordinatesUseCaseMockMock()

    public init(){}
    
    public func callAsFunction(latitude: Double, longitude: Double) {
        mock.callAsFunction(latitude: latitude, longitude: longitude)
    }
}

extension LaunchWikipediaWithCoordinatesUseCaseMock {
    public final class LaunchWikipediaWithCoordinatesUseCaseMockMock: LaunchWikipediaWithCoordinatesUseCase {
        public var callAsFunctionCalls = Mock<(Double, Double), Void>(defaultReturnValue: ())

        public func callAsFunction(latitude: Double, longitude: Double) {
            callAsFunctionCalls.record((latitude, longitude))
        }
    }
}
