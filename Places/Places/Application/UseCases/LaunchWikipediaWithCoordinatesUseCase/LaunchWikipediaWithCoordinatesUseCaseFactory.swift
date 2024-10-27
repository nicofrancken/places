//
//  LaunchWikipediaWithCoordinatesUseCaseFactory.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

final class LaunchWikipediaWithCoordinatesUseCaseFactory {
    static let shared = LaunchWikipediaWithCoordinatesUseCaseFactory()
    
    private init() {}
    
    func getInstance() -> LaunchWikipediaWithCoordinatesUseCase {
        LaunchWikipediaWithCoordinatesUseCaseImp(wikipediaAppLauncher: WikipediaAppLauncherFactory.shared.getInstance())
    }
}
