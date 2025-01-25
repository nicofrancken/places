//
//  Location.swift
//  PlacesDomain
//
//  Created by Nico Francken on 29/10/2024.
//

public struct Location: Decodable, Equatable, Identifiable, Sendable {
    public let name: String?
    public let latitude: Double
    public let longitude: Double
    
    public init(name: String?, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public var id: String { "\(latitude)-\(longitude)" }
}
