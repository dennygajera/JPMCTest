//
//  MockUrlSession.swift
//  JPMCTestTests
//
//  Created by Darshan Gajera on 08/05/2023.
//

import Foundation

class NetworkSessionMock: NetworkSession {
    var data: Data?
    func getWebService(url: URL) async throws -> Data {
        if let data = data {
            return data
        }
        throw APIError.noData
    }
}
