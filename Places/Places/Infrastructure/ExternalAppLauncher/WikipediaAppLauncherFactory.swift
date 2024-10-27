//
//  WikipediaAppLauncherFactory.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

final class WikipediaAppLauncherFactory {
    static let shared = WikipediaAppLauncherFactory()
    
    private init() {}
    
    func getInstance() -> WikipediaAppLauncher {
        WikipediaAppLauncherImp(externalAppLauncher: ExternalAppLauncherFactory.shared.getInstance())
    }
}
