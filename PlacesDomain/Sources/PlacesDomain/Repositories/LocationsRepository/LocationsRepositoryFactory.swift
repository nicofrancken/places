//
//  LocationsRepositoryFactory.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import PlacesInfrastructure

public final class LocationsRepositoryFactory: Sendable {
    public static let shared = LocationsRepositoryFactory()
    
    private init() {}
    
    public func getInstance() -> LocationsRepository {
        LocationsRepositoryImp(locationsApi: LocationsApiFactory.shared.getInstance())
    }
}
