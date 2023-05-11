//
//  NSManagedObject+Additions.swift
//  JPMCTest
//
//  Created by Darshan Gajera on 08/05/2023.
//

import CoreData

extension NSManagedObject {
    class var entityName: String { Self.entity().name! }
    public var entityName: String { return type(of: self).entityName }
}
