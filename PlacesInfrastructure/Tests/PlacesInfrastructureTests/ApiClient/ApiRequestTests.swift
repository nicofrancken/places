//
//  ApiRequestTests.swift
//  PlacesTests
//
//  Created by Nico Francken on 27/10/2024.
//

import XCTest
import Foundation

@testable import PlacesInfrastructure

final class ApiRequestTests: XCTestCase {
    func testApiRequest() {
        // Given
        let request = TestRequest()
        let expectedUrl = URL(string: "https://test.com/testObjects")!
        
        
        // When
        guard let url = request.toUrl() else {
            XCTFail("UrlRequest is nil")
            return
        }
        
        // Then
        XCTAssertEqual(expectedUrl, url)
    }
}

struct TestRequest: ApiRequest, Sendable {
    typealias ResponseType = [TestObject]
    var baseURL = "https://test.com"
    var path: String = "testObjects"
    var method: HttpMethod = .get
    var parameters: [String : String]? = ["param1": "value1",
                                       "param2": "value2"]
    var headers: [String : String]? = nil
}
