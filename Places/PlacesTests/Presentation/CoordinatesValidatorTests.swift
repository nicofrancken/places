//
//  CoordinatesValidatorTests.swift
//  PlacesTests
//
//  Created by Nico Francken on 29/10/2024.
//

import XCTest

@testable import Places

final class CoordinatesValidatorTests: XCTestCase {
    func testValidLatitudesReturnNil() {
        // Given
        let validLatitudes = ["-90", "90", "2.2", "3.111111"]
        
        // WHEN
        var results = [CoordinateValidationError?]()
        
        validLatitudes.forEach { latitude in
            let result = CoordinatesValidator.validate(latitude: latitude, longitude: "0")
            
            results.append(result)
        }
        
        // Then
        results.forEach { result in
            XCTAssertNil(result)
        }
    }
    
    func testInvalidLatitudesReturnLatitudeError() {
        // Given
        let invalidLatitudes = ["-91", "91", "A", "@"]
        
        // WHEN
        var results = [CoordinateValidationError?]()
        
        invalidLatitudes.forEach { latitude in
            let result = CoordinatesValidator.validate(latitude: latitude, longitude: "0")
            
            results.append(result)
        }
        
        // Then
        results.forEach { result in
            XCTAssertEqual(result, CoordinateValidationError.invalidLatitude)
        }
    }
    
    func testValidLongitudessReturnNil() {
        // Given
        let validLongitudes = ["-180", "180", "2.2", "3.111111"]
        
        // WHEN
        var results = [CoordinateValidationError?]()
        
        validLongitudes.forEach { longitude in
            let result = CoordinatesValidator.validate(latitude: "0", longitude: longitude)
            
            results.append(result)
        }
        
        // Then
        results.forEach { result in
            XCTAssertNil(result)
        }
    }
    
    func testInvalidLongitudesReturnLongitudeError() {
        // Given
        let invalidLongitudes = ["-181", "181", "A", "@"]
        
        // WHEN
        var results = [CoordinateValidationError?]()
        
        invalidLongitudes.forEach { longitude in
            let result = CoordinatesValidator.validate(latitude: "0", longitude: longitude)
            
            results.append(result)
        }
        
        // Then
        results.forEach { result in
            XCTAssertEqual(result, CoordinateValidationError.invalidLongitude)
        }
    }
}
