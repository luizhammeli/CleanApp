//
//  Storyboarded.swift
//  UI
//
//  Created by Luiz Diniz Hammerli on 18/09/21.
//

import UIKit

public protocol Storyboarded {
    static func instantiate() -> Self?
}

extension Storyboarded where Self: UIViewController {
    public static func instantiate() -> Self? {
        let className = String(describing: self)
        guard let bundleName = className.components(separatedBy: "ViewController").first else { return nil }
        let storyboard = UIStoryboard(name: bundleName, bundle: Bundle(for: Self.self))
        let sut = storyboard.instantiateViewController(identifier: className) as? Self
        return sut
    }
}
