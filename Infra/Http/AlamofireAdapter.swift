//
//  AlamofireAdapter.swift
//  Infra
//
//  Created by Luiz Diniz Hammerli on 05/09/21.
//

import Foundation
import Alamofire
import Data

public final class AlamofireAdapter: HttpPostClient {
    private let session: Alamofire.Session
    
    public init(session: Alamofire.Session = .default) {
        self.session = session
    }
    
    public func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        var json: [String: Any]?
        json = data?.toDictionary()
        session.request(url, method: .post, parameters: json, encoding: JSONEncoding.default).responseData { responseData in
            guard let statusCode = responseData.response?.statusCode else { completion(.failure(.noConnectivity)); return }
            switch responseData.result {
            case .success(let data):
                switch statusCode {
                case 204:
                    completion(.success(nil))
                case 200...299:
                    completion(.success(data))
                case 401:
                    completion(.failure(.unauthorized))
                case 403:
                    completion(.failure(.forbidden))
                case 400...499:
                    completion(.failure(.badRequest))
                case 500...599:
                    completion(.failure(.serverError))
                default:
                    completion(.failure(.noConnectivity))
                }
            case .failure(_):
                completion(.failure(.noConnectivity))
            }
        }
    }
}
