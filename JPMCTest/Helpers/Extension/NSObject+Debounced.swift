//
//  NSObject+Debounced.swift
//  JPMCTest
//
//  Created by Darshan Gajera on 08/05/2023.
//

import Foundation

public extension NSObject {
    /// Debounces calls to the `selector` based on the passed in delay.
    func performDebounced(_ selector: Selector, with object: Any? = nil, afterDelay delay: TimeInterval = 1) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: selector, object: object)
        perform(selector, with: object, afterDelay: delay, inModes: [.common])
    }
}
