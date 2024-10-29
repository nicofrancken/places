//
//  WikipediaAppLauncher.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

public protocol WikipediaAppLauncher {
    func launchToPlaces(with coordinates: Coordinates) async
}
