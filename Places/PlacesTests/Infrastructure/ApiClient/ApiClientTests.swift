//
//  ApiClientTests.swift
//  PlacesTests
//
//  Created by Nico Francken on 27/10/2024.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubsSwift

@testable import Places

final class ApiClientTests: XCTestCase {
    private var apiClient: ApiClient!
    
    override func setUpWithError() throws {
        apiClient = ApiClientImp()
    }

    func testGetDecodeSucceeds() async throws {
        // Given
        let testData = [TestObject(item1: "Value 1A", item2: "Value 1B"),
                        TestObject(item1: "Value 2A", item2: "Value 2B"),
                        TestObject(item1: "Value 3A", item2: "Value 3B")]
        
        let request = TestGetRequest()
        let jsonData = try JSONEncoder().encode(testData)
        
        stub(condition: isAbsoluteURLString(request.toUrl()!.absoluteString)) { _ in
            return HTTPStubsResponse(data: jsonData,
                                     statusCode: 200,
                                     headers: nil)
        }
        
        // When
        let result = try await apiClient.execute(request)
        
        // Then
        XCTAssertEqual(result, testData)
    }
    
    func testGetDecodeFails() async throws {
        // Given
        let testData = [TestObject(item1: "Value 1A", item2: "Value 1B"),
                        TestObject(item1: "Value 2A", item2: "Value 2B"),
                        TestObject(item1: "Value 3A", item2: "Value 3B")]
        let request = WrongGetRequest()
        let jsonData = try JSONEncoder().encode(testData)
        
        stub(condition: isAbsoluteURLString(request.toUrl()!.absoluteString)) { _ in
            return HTTPStubsResponse(data: jsonData,
                                     statusCode: 200,
                                     headers: nil)
        }
        
        // When
        do {
            _ = try await apiClient.execute(request)
            
            XCTFail("Expected decoding error")
        } catch {
            // Then
            switch error {
            case ApiClientError.decodingError:
                return
            default:
                XCTFail("Expected decoding error")
            }
        }
    }
    
    func test404HttpErrorResultsInResponseError() async throws {
        // Given
        let request = TestGetRequest()

        stub(condition: isAbsoluteURLString(request.toUrl()!.absoluteString)) { _ in
            return HTTPStubsResponse(data: String("Not found").data(using: .utf8)!,
                                     statusCode: 404,
                                     headers: nil
            )
        }
        
        // When
        do {
            _ = try await apiClient.execute(request)
            
            XCTFail("Expected response error")
        } catch {
            // Then
            if case ApiClientError.responseError(_, let responseCode) = error {
                XCTAssertEqual(responseCode, 404)
            } else {
                XCTFail("Expected response error")
            }
        }
    }
    
    func testNonResponseErrorResultsInNetworkError() async throws {
        // Given
        let request = TestGetRequest()
        
        stub(condition: isAbsoluteURLString(request.toUrl()!.absoluteString)) { _ in
            return HTTPStubsResponse(error: NSError(domain: "", code: 999))
        }
        
        // When
        do {
            _ = try await apiClient.execute(request)
            
            XCTFail("Expected network error")
        } catch {
            // Then
            if case ApiClientError.networkError = error {
                return
            } else {
                XCTFail("Expected network error")
            }
        }
    }
    
    func testInvalidRequestResultsInInvalidRequestError() async throws {
        // Given
        let request = InvalidGetRequest()
        
        // When
        do {
            _ = try await apiClient.execute(request)
            
            XCTFail("Expected invalid request error")
        } catch {
            // Then
            if case ApiClientError.invalidRequest = error {
                return
            } else {
                XCTFail("Expected invalid request error")
            }
        }
    }
}

struct TestGetRequest: ApiRequest {
    typealias ResponseType = [TestObject]
    var baseURL = "https://test.com"
    var path: String = "testObjects"
    var method: HttpMethod = .get
    var parameters: [String : Any]? = nil
    var headers: [String : String]? = ["bearer": "testToken"]
}
                                     
struct WrongGetRequest: ApiRequest {
     typealias ResponseType = TestObject //No array
     var baseURL = "https://test.com"
     var path: String = "testObjects"
     var method: HttpMethod = .get
     var parameters: [String : Any]? = nil
     var headers: [String : String]? = nil
 }

struct InvalidGetRequest: ApiRequest {
     typealias ResponseType = TestObject //No array
     var baseURL = "https://www.example.com:invalidport"
     var path: String = "@#testObject&&&&&s"
     var method: HttpMethod = .get
     var parameters: [String : Any]? = nil
     var headers: [String : String]? = nil
 }

struct TestObject: Codable, Equatable {
    let item1: String
    let item2: String
}
