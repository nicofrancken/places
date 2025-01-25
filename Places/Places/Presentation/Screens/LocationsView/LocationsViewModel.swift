//
//  LocationsViewModel.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

import SwiftUI
import PlacesDomain

@MainActor
class LocationsViewModel: ObservableObject {
    private var locations: [Location] = []
    @Published var state: LocationsViewState = .empty
    @Published var viewError: LocationsViewError?
    
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
            state = .loading
            locations = try await getLocationsUseCase()
            state = .loaded(locations)
        } catch {
            viewError = .locationPolulationFailed
        }

    }
    
    func addLocation(_ location: Location) async {
        guard !locations.contains(location) else {
            viewError = .locationAlreadyAdded
            return
        }
        
        locations.append(location)
        
        await launchWiki(location)
    }
    
    func launchWiki(_ location: Location) async {
        state = .loaded(locations, selectedLocation: location)
        
        await launchWikipediaWithCoordinatesUseCase(latitude: location.latitude,
                                                    longitude: location.longitude)
    }
}
