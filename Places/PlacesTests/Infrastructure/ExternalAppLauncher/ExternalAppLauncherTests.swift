//
//  ExternalAppLauncherTests.swift
//  PlacesTests
//
//  Created by Nico Francken on 27/10/2024.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift

@testable import Places

final class ExternalAppLauncherTests: XCTestCase {
    private var externalAppLauncher: ExternalAppLauncher!
    
    override func setUpWithError() throws {
        externalAppLauncher = ExternalAppLauncherImp()
    }
    
    func testLaunchExternal() {
        let url = "www.google.com"
        externalAppLauncher.launch(with: URL(string: url)!)
        
        stub(condition: isAbsoluteURLString(url)) { _ in
            return HTTPStubsResponse(error: NSError(domain: "", code: 999))
        }
    }
}
