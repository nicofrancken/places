//
//  LaunchWikipediaWithCoordinatesUseCaseImp.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

import PlacesInfrastructure

public class LaunchWikipediaWithCoordinatesUseCaseImp: LaunchWikipediaWithCoordinatesUseCase {
    private let wikipediaAppLauncer: WikipediaAppLauncher
    
    public init (wikipediaAppLauncher: WikipediaAppLauncher) {
        self.wikipediaAppLauncer = wikipediaAppLauncher
    }

    public func callAsFunction(latitude: Double, longitude: Double) async {
        await self.wikipediaAppLauncer.launchToPlaces(with: Coordinates(latitude: latitude,
                                                                        longitude: longitude))
    }
}
