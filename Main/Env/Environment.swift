//
//  Enviroment.swift
//  Main
//
//  Created by Luiz Diniz Hammerli on 20/09/21.
//

import Foundation

final class Environment {
    enum Variables: String {
        case apiBaseURL = "API_BASE_URL"
    }
    
    static func variable(for key: Variables) -> String {
        return Bundle.main.infoDictionary?[key.rawValue] as! String
    }
}
