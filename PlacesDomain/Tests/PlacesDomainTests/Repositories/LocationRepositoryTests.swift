//
//  LocationRepositoryTests.swift
//  PlacesTests
//
//  Created by Nico Francken on 27/10/2024.
//

import XCTest
import PlacesInfrastructure
import PlacesInfrastructureMocks

@testable import PlacesDomainMocks
@testable import PlacesDomain

final class LocationRepositoryTests: XCTestCase {
    private var locationApiMock: LocationsApiMock!
    private var locationRepository: LocationsRepository!
    
    override func setUpWithError() throws {
        locationApiMock = LocationsApiMock()
        locationRepository = LocationsRepositoryImp(locationsApi: locationApiMock)
    }

    func testGetLocationApiSuccessful() async throws {
        // Given
        let locations: [LocationDTO] = [LocationDTO(name: "Location1", lat: 0.0, long: 0.1),
                                        LocationDTO(name: "Location1", lat: 1.0, long: 0.12)]
        let expectedLocations = locations.map { $0.toEntity() }
        
        locationApiMock.mock.getLocationsCalls.mockCall { _ in
            return locations
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
        } catch _ as LocationsApiError {
            // Then
            return
        } catch {
            XCTFail("Expected LocationsApiError to be thrown")
        }
    }
}
