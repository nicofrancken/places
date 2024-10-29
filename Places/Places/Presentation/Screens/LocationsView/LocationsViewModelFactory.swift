//
//  LocationsViewModelFactory.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import PlacesDomain

final class LocationsViewModelFactory {
    static let shared = LocationsViewModelFactory()
    
    private init() {}
    
    func getInstance() -> LocationsViewModel {
        LocationsViewModel(getLocationsUseCase: GetLocationsUseCaseFactory.shared.getInstance(),
                           launchWikipediaWithCoordinatesUseCase: LaunchWikipediaWithCoordinatesUseCaseFactory.shared.getInstance())
    }
}
