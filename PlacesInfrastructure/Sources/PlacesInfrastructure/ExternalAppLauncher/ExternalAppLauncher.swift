//
//  ExternalAppLauncher.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

import Foundation

public protocol ExternalAppLauncher {
    func launch(with url: URL) async
}
