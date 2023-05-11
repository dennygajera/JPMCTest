//
//  PlanetCellTests.swift
//  JPMCTestTests
//
//  Created by Darshan Gajera on 08/05/2023.
//

import XCTest
import CoreData

final class PlanetCellTests: XCTestCase {

    var sut: PlanetCell!
    override func setUpWithError() throws {
        try super.setUpWithError()
        let bundle = Bundle(for: type(of: self))
        guard let cell = bundle.loadNibNamed("\(PlanetCell.self)", owner: nil)?.first as? PlanetCell else {
            XCTFail("Unable to create cell")
            return
        }
        sut = cell
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testSetData() {
        DataManager.shared.load { _ in }
        let planetData = Planet(context: DataManager.shared.viewContext)
        planetData.name = "P1"
        planetData.climate = "good"
        sut.setData(planetData)
        XCTAssertEqual(sut.planetNameLabel.text, "P1")
    }
}
