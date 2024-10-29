//
//  LocationsViewModel.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

import SwiftUI
import PlacesDomain
import PlacesInfrastructure

class LocationsViewModel: ObservableObject {
    @Published var locations = [Location]()
    @Published var selectedLocation: Location?
    @Published var error: LocationsViewError?
    @Published var isLoading = false
    
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
            let newLocations = try await getLocationsUseCase()
            await updateLocationsUIState(newLocations: newLocations)
        } catch {
            await updateErrorUIState(error: .locationPolulationFailed)
        }
    }
    
    @MainActor
    func selectLocation(_ location: Location) {
        selectedLocation = location
        launchWiki(location)
    }
    
    @MainActor
    func opem(_ customLocation: Location) {
        selectedLocation = customLocation
        launchWiki(customLocation)
    }
    
    func launchWiki(_ location: Location) {
        Task {
            await launchWikipediaWithCoordinatesUseCase(latitude: location.lat,
                                                        longitude: location.long)
        }
    }
    
    @MainActor
    private func updateLocationsUIState(newLocations: [Location]) {
        self.locations = newLocations
    }
    
    @MainActor
    private func updateErrorUIState(error: LocationsViewError) {
        self.error = error
    }
}
