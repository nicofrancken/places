//
//  WikipediaAppLauncherMock.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import MockFramework

@testable import Places

final class WikipediaAppLauncherMock: WikipediaAppLauncher {
    let mock = WikipediaAppLauncherMockMock()

    func launchToPlaces(with coordinates: Coordinates) {
        mock.launchToPlacesCalls.record(coordinates)
    }
}

extension WikipediaAppLauncherMock {
    final class WikipediaAppLauncherMockMock {
        var launchToPlacesCalls = Mock<Coordinates, Void>(defaultReturnValue: ())

        func launchToPlaces(with coordinates: Coordinates) {
            launchToPlacesCalls.record(coordinates)
        }
    }
}
