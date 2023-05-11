//
//  MockPlanetData.swift
//  JPMCTestTests
//
//  Created by Darshan Gajera on 08/05/2023.
//

import CoreData

class MockPlanetData {
    func getPlanetDataFromFile() -> Data {
        return dataFromJSON(withName: "MockPlanetData")!
    }
}

func dataFromJSON(withName name: String) -> Data? {
    guard let fileURL = Bundle(for: JPMCTestTests.self).url(forResource: name, withExtension: "json") else {
        return nil
    }
    return try? Data(contentsOf: fileURL)
}
