//
//  GetLocationsUseCaseTests.swift
//  PlacesTests
//
//  Created by Nico Francken on 27/10/2024.
//

import XCTest
import PlacesInfrastructure

@testable import PlacesDomainMocks
@testable import PlacesDomain

final class GetLocationsUseCaseTests: XCTestCase {
    private var locationsRepositoryMock: LocationsRepositoryMock!
    private var getLocationsUseCase: GetLocationsUseCase!
    
    override func setUpWithError() throws {
        locationsRepositoryMock = LocationsRepositoryMock()
        getLocationsUseCase = GetLocationsUseCaseImp(locationsRepository: locationsRepositoryMock)
    }

    func testProxyRepositoryGetLocations() async throws {
        // Given
        let expectedLocations: [Location] = [Location(name: "Location1", lat: 0.0, long: 0.1)]
        
        locationsRepositoryMock.mock.getAllLocationsCalls.mockCall { _ in
            return expectedLocations
        }
        
        // When
        let result = try await getLocationsUseCase()
        
        // Then
        XCTAssertEqual(expectedLocations, result)
    }
    
    func testProxyRepostoryError() async throws {
        // Given
        locationsRepositoryMock.mock.getAllLocationsCalls.mockCall { _ in
            throw NSError(domain: "", code: 0)
        }
        
        // When
        do {
            _ = try await getLocationsUseCase()
            
            assertionFailure("Should not have succeeded")
            
        } catch {
            // Then
            XCTAssertEqual(error as NSError, NSError(domain: "", code: 0))
        }
    }
}
