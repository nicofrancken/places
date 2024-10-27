//
//  ExternalAppLauncherMock.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import Foundation
import MockFramework

@testable import Places

final class ExternalAppLauncherMock: ExternalAppLauncher {
    let mock = ExternalAppLauncherMockMock()

    func launch(with url: URL) {
        mock.launchCalls.record(url)
    }
}

extension ExternalAppLauncherMock {
    final class ExternalAppLauncherMockMock {
        var launchCalls = Mock<URL, Void>(defaultReturnValue: ())

        func launch(with url: URL) {
            launchCalls.record(url)
        }
    }
}
