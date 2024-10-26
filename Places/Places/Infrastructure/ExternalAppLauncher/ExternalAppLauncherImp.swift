//
//  ExternalAppLauncherImp.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

import UIKit

class ExternalAppLauncherImp: ExternalAppLauncher {
    func launch(with url: URL) {
        UIApplication.shared.open(url)
    }
}
