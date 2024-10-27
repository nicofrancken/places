//
//  ApiClientImp.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

import Alamofire
import Foundation

class ApiClientImp: ApiClient {
    private let session: Session
    
    init() {
        let configuration = URLSessionConfiguration.af.default
        session = Session(configuration: configuration)
    }
    
    func execute<T : ApiRequest>(_ request: T) async throws -> T.ResponseType {
        guard let url = request.toUrl() else {
            throw ApiClientError.invalidRequest
        }
        
        let response = await self.session
            .request(url,
                     method: request.method.toHTTPMethod(),
                     parameters: request.parameters,
                     encoding: JSONEncoding.default,
                     headers:  toHTTPHeaders(request.headers))
            .validate()
            .serializingDecodable(T.ResponseType.self)
            .response
        
        switch response.result {
        case .success(let value):
            return value
        case .failure(let error):
            throw mapError(error: error)
        }
    }
    
    private func toHTTPHeaders(_ headersDict: [String: String]?) -> HTTPHeaders? {
        guard let headersDict, headersDict.count > 0 else { return nil }
        
        return HTTPHeaders(headersDict.map { HTTPHeader(name: $0.key, value: $0.value) })
    }
    
    private func mapError(error: Error, data: Data? = nil) -> Error {
        guard let alamofireError = error as? AFError else { return error }
        
        if alamofireError.isResponseValidationError {
            return ApiClientError.responseError(error: alamofireError,
                                                responseCode: alamofireError.responseCode)
        }
        
        if alamofireError.isResponseSerializationError {
            return ApiClientError.decodingError(error: alamofireError)
        }

        // TODO: To be replaced by mapping the different error categories to specific customer error types
        return ApiClientError.networkError(error: alamofireError)
    }
}

extension HttpMethod {
    func toHTTPMethod() -> HTTPMethod {
        switch self {
        case .get:
            return .get
        case .put:
            return .put
        case .post:
            return .post
        case .delete:
            return .delete
        }
    }
}
