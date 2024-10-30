//
//  LocationsViewModel.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

import SwiftUI
import PlacesDomain

class LocationsViewModel: ObservableObject {
    @Published var locations = [Location]()
    @Published var selectedLocation: Location?
    @Published var error: LocationsViewError?
    
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
            await updateLocations(newLocations: newLocations)
        } catch {
            await updateError(error: .locationPolulationFailed)
        }
    }
    
    @MainActor
    func launchWiki(_ location: Location) async {
        selectedLocation = location
        await launchWikipediaWithCoordinatesUseCase(latitude: location.latitude,
                                                    longitude: location.longitude)
    }
    
    @MainActor
    private func updateLocations(newLocations: [Location]) {
        self.locations = newLocations
    }
    
    @MainActor
    private func updateError(error: LocationsViewError) {
        self.error = error
    }
}
