//
//  WikipediaAppLauncherImp.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

import Foundation

class WikipediaAppLauncherImp: WikipediaAppLauncher {
    private let baseUrl = "wikipedia://places"
    private let externalAppLauncher: ExternalAppLauncher
    
    
    init(externalAppLauncher: ExternalAppLauncher) {
        self.externalAppLauncher = externalAppLauncher
    }
    
    func launchToPlaces(with coordinates: Coordinates) {
        guard let url = URL(string: baseUrl),
           var urlComponents = URLComponents(url: url,
                                                  resolvingAgainstBaseURL: false) else {
           return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "WMFLatitude",
                         value: "\(coordinates.latitude)"),
            URLQueryItem(name: "WMFLongitude",
                         value: "\(coordinates.longitude)")
        ]
        
        guard let constructedUrl = urlComponents.url else {
            return
        }
        
        externalAppLauncher.launch(with: constructedUrl)
    }
}
