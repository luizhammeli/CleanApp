//
//  CustomNavigationController.swift
//  UI
//
//  Created by Luiz Diniz Hammerli on 05/10/21.
//

import Foundation
import UIKit

public class CustomNavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let appereance = UINavigationBarAppearance()
        appereance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appereance.backgroundColor = Color.primaryDark
        navigationBar.tintColor = .white
        navigationBar.standardAppearance = appereance
        navigationBar.scrollEdgeAppearance = appereance
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public func setRootViewController(_ controller: UIViewController) {
        setViewControllers([controller], animated: true)
        controller.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, image: nil, primaryAction: nil, menu: nil)
    }
    
    public func pushViewController(_ controller: UIViewController) {
        pushViewController(controller, animated: true)
        controller.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, image: nil, primaryAction: nil, menu: nil)
    }
}
