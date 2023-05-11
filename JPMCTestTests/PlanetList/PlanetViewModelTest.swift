//
//  PlanetViewModelTest.swift
//  JPMCTestTests
//
//  Created by Darshan Gajera on 08/05/2023.
//

import XCTest

class PlanetViewModelTest: XCTestCase {
    var sut: PlanetListViewModel!
    var mockSession: NetworkSessionMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockSession = NetworkSessionMock()
        mockSession.data = MockPlanetData().getPlanetDataFromFile()
        sut = PlanetListViewModel(serviceHandler: WebServiceHandler(session: mockSession))
        DataManager.shared.load { _ in }
    }
    
    func testFetchAllPlanetFromAPI() async {
        try? await sut.fetchAllPlanetFromAPI()
        XCTAssertGreaterThan(sut.noOfPlanets, 8)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        mockSession = nil
        try super.tearDownWithError()
    }
    
}
