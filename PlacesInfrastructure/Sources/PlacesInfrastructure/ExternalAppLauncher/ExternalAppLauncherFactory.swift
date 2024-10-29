//
//  ExternalAppLauncherFactory.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

public final class ExternalAppLauncherFactory: Sendable {
    static let shared = ExternalAppLauncherFactory()
    
    private init() {}
    
    func getInstance() -> ExternalAppLauncher {
        ExternalAppLauncherImp()
    }
}
