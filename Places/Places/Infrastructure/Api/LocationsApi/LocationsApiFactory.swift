//
//  LocationsApiFactory.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

final class LocationsApiFactory {
    static let shared = LocationsApiFactory()
    
    private init() {
    }
    
    func getInstance() -> LocationsApi {
        LocationsApiImp(apiClient: ApiClientFactory.shared.getInstance())
    }
}
