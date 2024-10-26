//
//  LocationsViewModel.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

import SwiftUI

@MainActor
class LocationsViewModel: ObservableObject {
    @Published var locations = [LocationUIState]()
    @Published var selectedLocation: LocationUIState?
    
    // Dependencies
    private let getLocationsUseCase: GetLocationsUseCase
    private let launchWikipediaWithCoordinatesUseCase: LaunchWikipediaWithCoordinatesUseCase
    
    init(getLocationsUseCase: GetLocationsUseCase,
         launchWikipediaWithCoordinatesUseCase: LaunchWikipediaWithCoordinatesUseCase) {
        self.getLocationsUseCase = getLocationsUseCase
        self.launchWikipediaWithCoordinatesUseCase = launchWikipediaWithCoordinatesUseCase
    }
    
    func populateLocations() async {
        do {
            self.locations = try await getLocationsUseCase().map {
                LocationUIState(name: $0.name ?? "",
                                latitude: $0.lat,
                                longitude: $0.long)
            }
        } catch {
            // TODO: Show error
            print("Error: \(error)")
        }
    }
    
    func selectLocation(_ location: LocationUIState) {
        selectedLocation = location
        
        launchWikipediaWithCoordinatesUseCase(latitude: location.latitude,
                                              longitude: location.longitude)
    }
}
