//
//  LocationsResultDTO.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

public struct LocationsResultDTO: Decodable, Sendable {
    let locations: [LocationDTO]
}
