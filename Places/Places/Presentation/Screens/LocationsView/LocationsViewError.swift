//
//  LocationsViewError.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

enum LocationsViewError: Error, Identifiable {
    case locationPolulationFailed
    case locationAlreadyAdded
    
    var id: Self { self }
}
