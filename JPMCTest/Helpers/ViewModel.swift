//
//  ViewModel.swift
//  JPMCTest
//
//  Created by Darshan Gajera on 08/05/2023.
//

import Foundation

class ViewModel {
    
    public var serviceHandler: WebServiceHandler
    public var dataManager: DataManager { DataManager.shared }
    
    // MARK: Life cycle
    
    init(serviceHandler: WebServiceHandler = WebServiceHandler()) {
        self.serviceHandler = serviceHandler
    }
    
}
