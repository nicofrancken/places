//
//  LaunchWikipediaWithCoordinatesUseCaseImp.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

class LaunchWikipediaWithCoordinatesUseCaseImp: LaunchWikipediaWithCoordinatesUseCase {
    private let wikipediaAppLauncer: WikipediaAppLauncher
    
    init (wikipediaAppLauncher: WikipediaAppLauncher) {
        self.wikipediaAppLauncer = wikipediaAppLauncher
    }

    func callAsFunction(latitude: Double, longitude: Double) {
        self.wikipediaAppLauncer.launchToPlaces(with: Coordinates(latitude: latitude,
                                                                  longitude: longitude))
    }
}
