//
//  LocationsViewState.swift
//  Places
//
//  Created by Nico Francken on 25/01/2025.
//

import PlacesDomain

enum LocationsViewState {
    case empty
    case loading
    case loaded([Location], selectedLocation: Location? = nil)
}
