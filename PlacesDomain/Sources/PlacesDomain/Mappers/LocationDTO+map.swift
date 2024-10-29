//
//  LocationDTO+map.swift
//  PlacesDomain
//
//  Created by Nico Francken on 29/10/2024.
//

import PlacesInfrastructure

extension LocationDTO {
    func toEntity() -> Location {
        Location(name: name, latitude: lat, longitude: long)
    }
}
