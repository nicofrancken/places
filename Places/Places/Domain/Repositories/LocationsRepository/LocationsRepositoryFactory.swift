//
//  LocationsRepositoryFactory.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

final class LocationsRepositoryFactory {
    static let shared = LocationsRepositoryFactory()
    
    private init() {}
    
    func getInstance() -> LocationsRepository {
        LocationsRepositoryImp(locationsApi: LocationsApiFactory.shared.getInstance())
    }
}
