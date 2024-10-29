//
//  GetLocationsUseCaseFactory.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import Foundation

public final class GetLocationsUseCaseFactory: Sendable {
    public static let shared = GetLocationsUseCaseFactory()

    private init() {}
    
    public func getInstance() -> GetLocationsUseCase {
        GetLocationsUseCaseImp(locationsRepository: LocationsRepositoryFactory.shared.getInstance())
    }
}
