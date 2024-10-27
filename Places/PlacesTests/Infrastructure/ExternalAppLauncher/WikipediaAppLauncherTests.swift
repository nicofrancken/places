//
//  WikipediaAppLauncherTests.swift
//  PlacesTests
//
//  Created by Nico Francken on 27/10/2024.
//

import XCTest

@testable import Places

final class WikipediaAppLauncherTests: XCTestCase {
    private var externalAppLauncherMock: ExternalAppLauncherMock!
    private var wikipediaAppLauncher: WikipediaAppLauncher!
    
    override func setUpWithError() throws {
        externalAppLauncherMock = ExternalAppLauncherMock()
        wikipediaAppLauncher = WikipediaAppLauncherImp(externalAppLauncher: externalAppLauncherMock)
    }

    func testLaunchApp() {
        // Given
        let expectedUrl = URL(string: "wikipedia://places?WMFLatitude=0.2&WMFLongitude=0.1")!
        
        // When
        wikipediaAppLauncher.launchToPlaces(with: Coordinates(latitude: 0.2, longitude: 0.1))
        
        // Then
        XCTAssertEqual(externalAppLauncherMock.mock.launchCalls.callsHistory, [expectedUrl])
    }
}
