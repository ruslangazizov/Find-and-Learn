//
//  NetworkManager.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 07.05.2022.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol: AnyObject {
    func perform<T: Decodable>(_ request: Request, _ completion: @escaping (Result<T, NetworkManagerError>) -> Void)
    func perform(_ request: Request, _ completion: @escaping (Result<Int, NetworkManagerError>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {
    // MARK: Dependencies
    
    private let encoder = JSONEncoder()
    
    // MARK: NetworkManagerProtocol
    
    func perform<T: Decodable>(_ request: Request, _ completion: @escaping (Result<T, NetworkManagerError>) -> Void) {
        AF.request(RequestAdapter(request, encoder)).responseDecodable { (dataResponse: AFDataResponse<T>) in
            if let statusCode = dataResponse.response?.statusCode, HTTP.StatusCode.server.contains(statusCode) {
                completion(.failure(.serverProblem))
            } else if let error = dataResponse.error {
                completion(.failure(.init(error)))
            } else if let model = dataResponse.value {
                completion(.success(model))
            } else {
                assertionFailure("Unknown error: \(dataResponse.debugDescription)")
                completion(.failure(.unknown))
            }
        }
    }
    
    func perform(_ request: Request, _ completion: @escaping (Result<Int, NetworkManagerError>) -> Void) {
        AF.request(RequestAdapter(request, encoder)).response { dataResponse in
            if let statusCode = dataResponse.response?.statusCode, HTTP.StatusCode.server.contains(statusCode) {
                completion(.failure(.serverProblem))
            } else if let error = dataResponse.error {
                completion(.failure(.init(error)))
            } else if let statusCode = dataResponse.response?.statusCode {
                completion(.success(statusCode))
            } else {
                assertionFailure("Unknown error: \(dataResponse.debugDescription)")
                completion(.failure(.unknown))
            }
        }
    }
}

private struct RequestAdapter: URLRequestConvertible {
    private let request: Request
    private let encoder: JSONEncoder
    
    init(_ request: Request, _ encoder: JSONEncoder) {
        self.request = request
        self.encoder = encoder
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: request.base + request.path) else {
            assertionFailure("Can not create url: \(request.base + request.path)")
            throw HTTP.Errors.incorrectUrl("Can not create url: \(request.base + request.path)")
        }
        
        var urlRequest = try URLRequest(
            url: url,
            method: .init(request.method)
        )
        
        urlRequest = try URLEncoding.queryString.encode(urlRequest, with: request.queries)
        
        switch request.body {
        case .raw(let data):
            urlRequest.httpBody = data
        case .model(let model):
            urlRequest.httpBody = try encoder.encode(AnyEncodable(model))
        case .keyValue(let dictionary):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        case .none:
            break
        }
        
        if request.body != .none {
            urlRequest.headers.add(.contentType("application/json"))
        }
        
        if !request.token.isEmpty {
            urlRequest.headers.add(.authorization(request.token))
        }
        
        return urlRequest
    }
}

private struct AnyEncodable: Encodable {
    private let encodable: Encodable
    
    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }
    
    func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }
}
