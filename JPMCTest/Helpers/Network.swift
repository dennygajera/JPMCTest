//
//  Network.swift
//  JPMCTest
//
//  Created by Darshan Gajera on 08/05/2023.
//

import Foundation
import Network

class Network: NSObject {
    
    public typealias ChangeHandler = (Bool) -> Void

    // MARK: - Properties (public)
    
    private(set) var isOnline: Bool = false
    public var isOffline: Bool { !isOnline }
    private var changeHandlers = [[String: (ChangeHandler)]]()

    // MARK: - Properties (private)
    
    private let monitor = NWPathMonitor()
    
    // MARK: - Life cycle
    
    static let shared = Network()
    
    
    // MARK: - API (public)

    public func startMonitoring() {
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        
        isOnline = monitor.currentPath.status == .satisfied
        
        monitor.pathUpdateHandler = { [unowned self] path in
            let newStatus = path.status == .satisfied
            guard isOnline != newStatus else { return }
            isOnline = newStatus
            printInfo()
        }
    }
    
    public func printInfo() {
        let availableInterfaces = monitor.currentPath.availableInterfaces
        
        guard !availableInterfaces.isEmpty else {
            debugPrint("Network Connected: NO")
            return
        }
        
        availableInterfaces.forEach {
            debugPrint("Network Connected: \(isOnline ? "YES" : "NO") | Type: \($0.type)")
        }
    }
    
}

