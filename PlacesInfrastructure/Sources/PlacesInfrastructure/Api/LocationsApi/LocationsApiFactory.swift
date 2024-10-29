//
//  LocationsApiFactory.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

public final class LocationsApiFactory: Sendable {
    public static let shared = LocationsApiFactory()
    
    private init() {
    }
    
    public func getInstance() -> LocationsApi {
        LocationsApiImp(apiClient: ApiClientFactory.shared.getInstance())
    }
}
