//
//  ExternalAppLauncherImp.swift
//  Places
//
//  Created by Nico Francken on 26/10/2024.
//

import UIKit

public class ExternalAppLauncherImp: ExternalAppLauncher {
    @MainActor public func launch(with url: URL) async {
        await withCheckedContinuation { continuation in
            UIApplication.shared.open(url) { _ in
                continuation.resume()
            }
        }

    }
}
