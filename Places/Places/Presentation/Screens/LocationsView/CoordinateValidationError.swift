//
//  CoordinateValidationError.swift
//  Places
//
//  Created by Nico Francken on 28/10/2024.
//

import SwiftUI

enum CoordinateValidationError: Identifiable {
    case invalidLatitude
    case invalidLongitude
    
    var id: Self { self }
    
    var LocalizedStringKey: LocalizedStringKey {
        switch self {
        case .invalidLatitude:
            "Invalid latitude"
        case .invalidLongitude:
            "Invalid longitude"
        }
        
    }
}
