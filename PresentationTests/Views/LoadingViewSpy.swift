//
//  LoadingViewSpy.swift
//  PresentationTests
//
//  Created by Luiz Diniz Hammerli on 11/09/21.
//

import Presentation

final class LoadingViewSpy: LoadingView {
    private var viewModel: LoadingViewModel?
    private var emiter: ((LoadingViewModel?) -> Void)?
    
    func display(viewModel: LoadingViewModel) {
        self.viewModel = viewModel
        emiter?(viewModel)
    }
    
    func observe(when isLoading: Bool = true, completion: @escaping (LoadingViewModel?) -> Void) {
        self.emiter = completion
    }
}
