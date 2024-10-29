//
//  LaunchWikipediaWithCoordinatesUseCase.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

public protocol LaunchWikipediaWithCoordinatesUseCase {
    func callAsFunction(latitude: Double, longitude: Double) async
}