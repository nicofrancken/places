//
//  GetLocationsUseCaseFactory.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

final class GetLocationsUseCaseFactory {
    static let shared = GetLocationsUseCaseFactory()
    
    private init() {}
    
    func getInstance() -> GetLocationsUseCase {
        GetLocationsUseCaseImp(locationsRepository: LocationsRepositoryFactory.shared.getInstance())
    }
}
