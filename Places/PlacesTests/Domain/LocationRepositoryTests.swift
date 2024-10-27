//
//  LocationRepositoryTests.swift
//  PlacesTests
//
//  Created by Nico Francken on 27/10/2024.
//

import XCTest

@testable import Places

final class LocationRepositoryTests: XCTestCase {
    private var locationApiMock: LocationsApiMock!
    private var locationRepository: LocationsRepository!
    
    override func setUpWithError() throws {
        locationApiMock = LocationsApiMock()
        locationRepository = LocationsRepositoryImp(locationsApi: locationApiMock)
    }

    func testGetLocationApiSuccessful() async throws {
        // Given
        let expectedLocations: [Location] = [Location(name: "Location1", lat: 0.0, long: 0.1),
                                             Location(name: "Location1", lat: 1.0, long: 0.12)]
        
        locationApiMock.mock.getLocationsCalls.mockCall { _ in
            return expectedLocations
        }
        
        // When
        let result = try await locationRepository.getAllLocations()
        
        // Then
        XCTAssertEqual(result, expectedLocations)
    }

    func testGetLocationApiFails() async throws {
        // Given
        let expectedError = LocationsApiError.errorRetrievingLocations(error: ApiClientError.invalidRequest)
        
        locationApiMock.mock.getLocationsCalls.mockCall { _ in
            throw expectedError
        }
        
        // When
        do {
            _ = try await locationRepository.getAllLocations()
            
            XCTFail("Expected LocationsApiError to be thrown")
        } catch let error as LocationsApiError {
            // Then
            return
        } catch {
            XCTFail("Expected LocationsApiError to be thrown")
        }
    }
}
