//
//  AlertViewModel.swift
//  Presentation
//
//  Created by Luiz Diniz Hammerli on 06/09/21.
//

import Foundation

public struct AlertViewModel: Equatable {
    public let title: String
    public let message: String
    
    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}

public protocol AlertView: AnyObject {
    func showMessage(viewModel: AlertViewModel)
}
