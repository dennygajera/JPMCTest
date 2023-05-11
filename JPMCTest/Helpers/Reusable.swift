//
//  Reusable.swift
//  JPMCTest
//
//  Created by Darshan Gajera on 08/05/2023.
//

import UIKit

public protocol ReusableView: AnyObject {}
public extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: ReusableView { }
public extension UIStoryboard {
    static var main : UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }

    func instantiateViewController<T>() -> T where T: ReusableView {
        return instantiateViewController(withIdentifier: T.reuseIdentifier) as! T
    }
}

extension UITableViewCell: ReusableView { }
public extension UITableView {
    func dequeueReusableCell<T>(for index : IndexPath) -> T where T : ReusableView {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: index) as! T
    }
}
