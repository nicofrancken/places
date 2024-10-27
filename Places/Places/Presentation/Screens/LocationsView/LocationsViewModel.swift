//
//  LocationsViewModel.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

import SwiftUI

class LocationsViewModel: ObservableObject {
    @Published var locations = [LocationUIState]()
    @Published var selectedLocation: LocationUIState?
    @Published var error: LocationsViewError?
    
    // Dependencies
    private let getLocationsUseCase: GetLocationsUseCase
    private let launchWikipediaWithCoordinatesUseCase: LaunchWikipediaWithCoordinatesUseCase
    
    init(getLocationsUseCase: GetLocationsUseCase,
         launchWikipediaWithCoordinatesUseCase: LaunchWikipediaWithCoordinatesUseCase) {
        self.getLocationsUseCase = getLocationsUseCase
        self.launchWikipediaWithCoordinatesUseCase = launchWikipediaWithCoordinatesUseCase
    }
    
    @MainActor func populateLocations() async {
        do {
            self.locations = try await getLocationsUseCase().map { $0.toLocationUIState() }
        } catch {
            self.error = LocationsViewError.locationPolulationFailed
        }
    }
    
    @MainActor func selectLocation(_ location: LocationUIState) {
        selectedLocation = location
        
        launchWikipediaWithCoordinatesUseCase(latitude: location.latitude,
                                              longitude: location.longitude)
    }
}
