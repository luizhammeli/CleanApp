//
//  AlertViewSpy.swift
//  PresentationTests
//
//  Created by Luiz Diniz Hammerli on 11/09/21.
//

import Presentation

final class AlertViewSpy: AlertView {
    private var viewModel: AlertViewModel?
    var emiter: ((AlertViewModel?) -> Void)?
    
    func showMessage(viewModel: AlertViewModel) {
        self.viewModel = viewModel
        emiter?(viewModel)
    }
    
    func observe(completion: @escaping (AlertViewModel?) -> Void) {
        self.emiter = completion
    }
}
