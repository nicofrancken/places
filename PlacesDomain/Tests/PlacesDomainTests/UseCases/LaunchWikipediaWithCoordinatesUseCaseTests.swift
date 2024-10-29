//
//  LaunchWikipediaWithCoordinatesUseCaseTests.swift
//  PlacesTests
//
//  Created by Nico Francken on 27/10/2024.
//

import XCTest

import PlacesInfrastructureMocks

@testable import PlacesDomainMocks
@testable import PlacesDomain

final class LaunchWikipediaWithCoordinatesUseCaseTests: XCTestCase {
    private var wikiPediaAppLauncherMock: WikipediaAppLauncherMock!
    private var launchWikipediaWithCoordinatesUseCase: LaunchWikipediaWithCoordinatesUseCase!
    
    override func setUpWithError() throws {
        wikiPediaAppLauncherMock = WikipediaAppLauncherMock()
        launchWikipediaWithCoordinatesUseCase = LaunchWikipediaWithCoordinatesUseCaseImp(wikipediaAppLauncher: wikiPediaAppLauncherMock)
    }

    func testLaunchWikiepedia() async throws {
        // Given
        let latitude = 0.0
        let longitude = 0.1
        
        // When
        await launchWikipediaWithCoordinatesUseCase(latitude: latitude, longitude: longitude)
        
        // Then
        XCTAssertEqual(wikiPediaAppLauncherMock.mock.launchToPlacesCalls.callsHistory.map { $0.latitude }, [latitude])
        XCTAssertEqual(wikiPediaAppLauncherMock.mock.launchToPlacesCalls.callsHistory.map { $0.longitude }, [longitude])
    }
}
