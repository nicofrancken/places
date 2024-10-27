//
//  ApiRequestTests.swift
//  PlacesTests
//
//  Created by Nico Francken on 27/10/2024.
//

import XCTest
import Foundation

@testable import Places

final class ApiRequestTests: XCTestCase {
    func testApiRequest() {
        // Given
        let request = TestRequest()
        let expectedUrlResult = URL(string: "https://test.com/testObjects?param1=value1&param2=value2")!
        
        // When
        guard let urlResult = request.toUrl() else {
            XCTFail("UrlRequest is nil")
            return
        }
        
        // Then
        XCTAssertTrue(urlsAreEqual(expectedUrlResult, urlResult))
    }
}

struct TestRequest: ApiRequest {
    typealias ResponseType = [TestObject]
    var baseURL = "https://test.com"
    var path: String = "testObjects"
    var method: HttpMethod = .get
    var parameters: [String : Any]? = ["param1": "value1",
                                       "param2": "value2"]
    var headers: [String : String]? = nil
}
