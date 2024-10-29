//
//  LaunchWikipediaWithCoordinatesUseCaseFactory.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import PlacesInfrastructure

public final class LaunchWikipediaWithCoordinatesUseCaseFactory: Sendable {
    public static let shared = LaunchWikipediaWithCoordinatesUseCaseFactory()
    
    private init() {}
    
    public func getInstance() -> LaunchWikipediaWithCoordinatesUseCase {
        LaunchWikipediaWithCoordinatesUseCaseImp(wikipediaAppLauncher: WikipediaAppLauncherFactory.shared.getInstance())
    }
}
