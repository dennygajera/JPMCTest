//
//  PlanetListViewControllerTest.swift
//  JPMCTestTests
//
//  Created by Darshan Gajera on 08/05/2023.
//

import XCTest

final class PlanetListViewControllerTest: XCTestCase {
    
    private var sut: PlanetListViewController!
    private var planetListViewModel: PlanetListViewModel!
    private var mockSession: NetworkSessionMock!
    
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockSession = NetworkSessionMock()
        mockSession.data = MockPlanetData().getPlanetDataFromFile()
        planetListViewModel = PlanetListViewModel(serviceHandler: WebServiceHandler(session: mockSession))
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle(for: Self.classForCoder()))
        let planetListViewController = storyBoard.instantiateViewController(withIdentifier: "PlanetListViewController") as! PlanetListViewController
        planetListViewController.viewModel = planetListViewModel
        sut = planetListViewController
        DataManager.shared.load { _ in }
    }
    
    func testFetchAllPlanetData() {
        XCTAssertNotNil(sut.fetchPlanets())
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
}
