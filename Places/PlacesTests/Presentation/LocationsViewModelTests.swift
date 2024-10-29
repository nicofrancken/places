//
//  LocationsViewModelTests.swift
//  PlacesTests
//
//  Created by Nico Francken on 27/10/2024.
//

import XCTest
import PlacesDomainMocks
import PlacesInfrastructure

@testable import Places

final class LocationsViewModelTests: XCTestCase {
    private var getLocationsUseCaseMock: GetLocationsUseCaseMock!
    private var launchWikipediaWithCoordinatesUseCaseMock: LaunchWikipediaWithCoordinatesUseCaseMock!
    private var locationsViewModel: LocationsViewModel!
    
    override func setUpWithError() throws {
        getLocationsUseCaseMock = GetLocationsUseCaseMock()
        launchWikipediaWithCoordinatesUseCaseMock = LaunchWikipediaWithCoordinatesUseCaseMock()
        
        locationsViewModel = LocationsViewModel(getLocationsUseCase: getLocationsUseCaseMock,
                                                launchWikipediaWithCoordinatesUseCase: launchWikipediaWithCoordinatesUseCaseMock)
    }
    
    func testGetLocationsSucceeds() async {
        // Given
        let expectedLocations: [Location] = [Location(name: "Location1", lat: 0.0, long: 0.1),
                                             Location(name: "Location1", lat: 1.0, long: 0.12)]
        
        getLocationsUseCaseMock.mock.callAsFunctionCalls.mockCall { _ in
            return expectedLocations
        }
        
        // When
        await locationsViewModel.populateLocations()
        
        // Then
        XCTAssertEqual(expectedLocations, locationsViewModel.locations)
    }
    
    func testGetLocationsFails() async {
        // Given
        getLocationsUseCaseMock.mock.callAsFunctionCalls.mockCall { _ in
            throw LocationsApiError.errorRetrievingLocations(error: ApiClientError.invalidRequest)
        }
        
        // When
        XCTAssertNil(locationsViewModel.error)
        await locationsViewModel.populateLocations()
        
        // Then
        XCTAssertEqual(locationsViewModel.locations, [])
        XCTAssertEqual(locationsViewModel.error, LocationsViewError.locationPolulationFailed)
    }
    
    func testLaunchWikipediaWithCoordinates() async {
        // Given
        let locations: [Location] = [Location(name: "Location1", lat: 0.0, long: 0.1),
                                             Location(name: "Location1", lat: 1.0, long: 0.12)]

        let expectedSelectedLocation = locations[0]
        getLocationsUseCaseMock.mock.callAsFunctionCalls.mockCall { _ in
            return locations
        }
        
        // When
        await locationsViewModel.selectLocation(expectedSelectedLocation)
        
        // Then
        XCTAssertEqual(expectedSelectedLocation, locationsViewModel.selectedLocation)
        XCTAssertEqual(launchWikipediaWithCoordinatesUseCaseMock.mock.callAsFunctionCalls.callsHistory.map { $0.0 }, [expectedSelectedLocation.lat])
        XCTAssertEqual(launchWikipediaWithCoordinatesUseCaseMock.mock.callAsFunctionCalls.callsHistory.map { $0.1 }, [expectedSelectedLocation.long])
    }
}
