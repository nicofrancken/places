//
//  Location.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

struct Location: Decodable, Equatable {
    let name: String?
    let lat: Double
    let long: Double
}
