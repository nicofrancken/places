//
//  LocationValidator.swift
//  Places
//
//  Created by Nico Francken on 28/10/2024.
//

class CoordinatesValidator {
    static func validate(latitude: String, longitude: String) -> CoordinateValidationError? {
        guard let latitude = Double(latitude), latitude >= -90 && latitude <= 90 else {
            return .invalidLatitude
        }
        
        guard let longitude = Double(longitude), longitude >= -180 && longitude <= 180 else {
            return .invalidLongitude
        }
                
        return nil
    }
}
