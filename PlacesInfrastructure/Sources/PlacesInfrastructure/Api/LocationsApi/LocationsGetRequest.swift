//
//  LocationsGetRequest.swift
//  Places
//
//  Created by Nico Francken on 25/10/2024.
//

import Foundation

struct LocationsGetRequest: ApiRequest, Sendable {
    typealias ResponseType = LocationsResult
    let baseURL: String
    let path: String = "abnamrocoesd/assignment-ios/main/locations.json"
    let method: HttpMethod = .get
    var parameters: [String : String]? = nil
    let headers: [String : String]? = nil
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
}
