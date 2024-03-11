//
//  Endpoint.swift
//  Rick&MortyApp
//
//  Created by Dimitri Altunashvili on 09.03.24.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
    var query: [String: Any]? { get }
}

extension Endpoint {
    var scheme: String { return "https" }
    var method: RequestMethod { .get }
    var header: [String: String]? { nil }
    var body: [String: Any]? { nil }
    var query: [String: String]? { nil }
}

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}
