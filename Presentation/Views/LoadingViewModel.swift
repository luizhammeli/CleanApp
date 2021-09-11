//
//  LoadingViewModel.swift
//  Presentation
//
//  Created by Luiz Diniz Hammerli on 09/09/21.
//

import Foundation

public struct LoadingViewModel: Equatable {
    public var isLoading: Bool
    
    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
}

public protocol LoadingView {
    func display(viewModel: LoadingViewModel)
}
