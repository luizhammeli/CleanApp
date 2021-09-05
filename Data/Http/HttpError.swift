//
//  HttpError.swift
//  Data
//
//  Created by Luiz Diniz Hammerli on 21/08/21.
//
import Foundation

public enum HttpError: Error {
    case noConnectivity
    case forbidden
    case unauthorized
    case serverError
    case badRequest
}
