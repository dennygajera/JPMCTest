//
//  PlanetListViewModel.swift
//  JPMCTest
//
//  Created by Darshan Gajera on 08/05/2023.
//

import Foundation
import Combine
import CoreData

class PlanetListViewModel: ViewModel {
    
    //MARK: Public
    
    private(set) var planetList = [Planet]()
    public var noOfPlanets: Int {
        planetList.count
    }
    
    //MARK: Methods
    
    enum Strings {
        public static let planets = "Planets"
    }
    
    func fetchAllPlanetFromAPI() async throws {
        
        defer {
            fetchAllPlanetFromCoreData()
        }
        
        if let data = try? await self.serviceHandler.getWebService(url: API.planetList.url) {
            let jsonObjects = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            if let results = jsonObjects?["results"] as? [[String: Any]] {
                DataManager.shared.createOrUpdateManagedObjects(using: results, mappedTo: EntityName.planet, save: true)
            }
        }
    }
    
    func fetchAllPlanetFromCoreData() {
        self.planetList = DataManager.shared.fetchManagedObjects(entityName: EntityName.planet) as! [Planet]
    }
    
    func dataForRowAt(_ indexPath: IndexPath) -> Planet? {
        if indexPath.row < noOfPlanets {
            return self.planetList[indexPath.row]
        }
        return nil
    }
}
