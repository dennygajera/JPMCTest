//
//  WebServiceHandler.swift
//  JPMCTest
//
//  Created by Darshan Gajera on 08/05/2023.
//

import Foundation

import Foundation

enum API : String {
    private static let baseURL = "https://swapi.dev/api/"
    case planetList = "planets"
    var url : URL {
        return URL(string: API.baseURL + self.rawValue)!
    }
}

enum APIError: Error {
    case error(Error)
    case noData
    case noInternetConnection
    case invalidResponseCode(Int)
}

protocol NetworkSession {
    func getWebService(url: URL) async throws -> Data
}

extension URLSession: NetworkSession {
    func getWebService(url: URL) async throws -> Data {
        let (data, response) = try await data(from: url)
        guard Network.shared.isOnline else {
            throw APIError.noInternetConnection
        }
        if let response = response as? HTTPURLResponse {
            switch response.statusCode {
            case 200...299:
                return data
            default:
                throw APIError.invalidResponseCode(response.statusCode)
            }
        }
        throw APIError.noData
    }
}

class WebServiceHandler {
    private let session: NetworkSession
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func getWebService(url: URL) async throws -> Data {
        return try await session.getWebService(url: url)
    }
}
