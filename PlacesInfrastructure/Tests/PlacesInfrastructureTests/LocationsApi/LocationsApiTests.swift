//
//  LocationsApiTests.swift
//  PlacesTests
//
//  Created by Nico Francken on 27/10/2024.
//

import XCTest

@testable import PlacesInfrastructureMocks
@testable import PlacesInfrastructure

final class LocationsApiTests: XCTestCase {
    private var apiClientMock: ApiClientMock!
    private var locationsApi: LocationsApi!
    
    override func setUpWithError() throws {
        apiClientMock = ApiClientMock()
        
        locationsApi = LocationsApiImp(apiClient: apiClientMock)
    }
    
    func testLocationsRequestSucceeds() async throws {
        // Given
        let expectedLocationResult = LocationsResult(locations: [Location(name: "Location1", lat: 0.0, long: 0.1),
                                                                 Location(name: "Location1", lat: 1.0, long: 0.12)])
        
        apiClientMock.mock.executeCalls.mockCall { _ in
            return expectedLocationResult
        }
        
        // When
        let result = try await locationsApi.getLocations()
        
        // Then
        XCTAssertEqual(result, expectedLocationResult.locations)
    }
    
    func testLocationRequestFails() async throws {
        // Given
        apiClientMock.mock.executeCalls.mockCall { _ in
            throw ApiClientError.invalidRequest
        }
        
        // When
        do {
            _ = try await locationsApi.getLocations()
            
            XCTFail("Expected Error retrieving locations")
        } catch {
            if case LocationsApiError.errorRetrievingLocations = error {
                // Then
                return
            } else {
                XCTFail("Expected Error retrieving locations")
            }
        }
    }
}
