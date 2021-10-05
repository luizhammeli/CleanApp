//
//  RoundedCustomTextField.swift
//  UI
//
//  Created by Luiz Diniz Hammerli on 04/10/21.
//

import UIKit

public final class RoundedCustomTextField: UITextField {
    public override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        layer.borderColor = Color.primaryLight?.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
    }
}
