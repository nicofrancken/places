//
//  WikipediaAppLauncherMock.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import MockFramework

@testable import PlacesInfrastructure

public final class WikipediaAppLauncherMock: WikipediaAppLauncher {
    public let mock = WikipediaAppLauncherMockMock()

    public init() {}
    
    public func launchToPlaces(with coordinates: Coordinates) {
        mock.launchToPlacesCalls.record(coordinates)
    }
}

extension WikipediaAppLauncherMock {
    public final class WikipediaAppLauncherMockMock {
        public var launchToPlacesCalls = Mock<Coordinates, Void>(defaultReturnValue: ())

        func launchToPlaces(with coordinates: Coordinates) {
            launchToPlacesCalls.record(coordinates)
        }
    }
}
