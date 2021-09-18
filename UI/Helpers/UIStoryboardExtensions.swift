//
//  UIStoryboardExtensions.swift
//  UI
//
//  Created by Luiz Diniz Hammerli on 18/09/21.
//

import UIKit

extension UIStoryboard {
    static func instantiate<T: UIViewController>(for aClass: T.Type) -> T? {
        let className = String(describing: aClass)
        guard let bundleName = className.components(separatedBy: "ViewController").first else { return nil }
        let storyboard = UIStoryboard(name: bundleName, bundle: Bundle(for: T.self))
        let sut = storyboard.instantiateViewController(identifier: className) as? T
        return sut
    }
}
