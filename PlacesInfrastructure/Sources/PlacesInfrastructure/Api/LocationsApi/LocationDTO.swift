//
//  Location.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

public struct LocationDTO: Decodable, Equatable, Sendable {
    public let name: String?
    public let lat: Double
    public let long: Double
    
    public init(name: String?, lat: Double, long: Double) {
        self.name = name
        self.lat = lat
        self.long = long
    }
}
