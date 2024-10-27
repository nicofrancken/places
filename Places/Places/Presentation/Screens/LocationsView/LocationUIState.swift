//
//  LocationUIState.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

struct LocationUIState: Identifiable, Equatable {
    let name: String?
    let latitude: Double
    let longitude: Double
    
    var id: String? { name }
}

extension Location {
    func toLocationUIState() -> LocationUIState {
        return LocationUIState(name: name,
                               latitude: lat,
                               longitude: long)
    }
}
