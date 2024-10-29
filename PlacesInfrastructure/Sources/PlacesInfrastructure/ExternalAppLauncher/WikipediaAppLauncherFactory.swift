//
//  WikipediaAppLauncherFactory.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

public final class WikipediaAppLauncherFactory: Sendable {
    public static let shared = WikipediaAppLauncherFactory()
    
    private init() {}
    
    public func getInstance() -> WikipediaAppLauncher {
        WikipediaAppLauncherImp(externalAppLauncher: ExternalAppLauncherFactory.shared.getInstance())
    }
}
