//
//  ExternalAppLauncherMock.swift
//  Places
//
//  Created by Nico Francken on 27/10/2024.
//

import Foundation
import MockFramework

@testable import PlacesInfrastructure

public final class ExternalAppLauncherMock: ExternalAppLauncher {
    let mock = ExternalAppLauncherMockMock()

    public func launch(with url: URL) async {
        await mock.launchCalls.record(url)
    }
}

extension ExternalAppLauncherMock {
    final class ExternalAppLauncherMockMock {
        var launchCalls = MockAsync<URL, Void>(defaultReturnValue: ())

        func launch(with url: URL) async {
            await launchCalls.record(url)
        }
    }
}
