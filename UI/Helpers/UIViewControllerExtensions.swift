//
//  UIViewControllerExtensions.swift
//  UI
//
//  Created by Luiz Diniz Hammerli on 18/09/21.
//

import UIKit

extension UIViewController {
    func hideKeyboardOnTap() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
