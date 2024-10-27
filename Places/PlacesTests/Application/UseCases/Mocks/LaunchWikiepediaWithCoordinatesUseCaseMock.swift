//
//  LaunchWikipediaWithCoordinatesUseCaseMock.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import MockFramework

@testable import Places

final class LaunchWikipediaWithCoordinatesUseCaseMock: LaunchWikipediaWithCoordinatesUseCase {
    let mock = LaunchWikipediaWithCoordinatesUseCaseMockMock()

    func callAsFunction(latitude: Double, longitude: Double) {
        mock.callAsFunction(latitude: latitude, longitude: longitude)
    }
}

extension LaunchWikipediaWithCoordinatesUseCaseMock {
    final class LaunchWikipediaWithCoordinatesUseCaseMockMock: LaunchWikipediaWithCoordinatesUseCase {
        var callAsFunctionCalls = Mock<(Double, Double), Void>(defaultReturnValue: ())

        func callAsFunction(latitude: Double, longitude: Double) {
            callAsFunctionCalls.record((latitude, longitude))
        }
    }
}
