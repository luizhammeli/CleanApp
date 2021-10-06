//
//  CustomNavigationController.swift
//  UI
//
//  Created by Luiz Diniz Hammerli on 05/10/21.
//

import Foundation
import UIKit

public class CustomNavigationController: UINavigationController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let appereance = UINavigationBarAppearance()
        appereance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appereance.backgroundColor = Color.primaryDark        
        navigationBar.tintColor = Color.primaryDark
        navigationBar.standardAppearance = appereance
        navigationBar.scrollEdgeAppearance = appereance
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
