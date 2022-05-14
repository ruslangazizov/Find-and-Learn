//
//  CreateDeckRequest.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 14.05.2022.
//

import Foundation

struct CreateDeckRequestModel: Encodable {
    let id: Int
    let name: String
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case userID = "user_id"
    }
}

struct CreateDeckRequest: Request {
    let method: HTTP.Method = .post
    let path: String = "decks/"
    let body: HTTP.Body
    let token: String
    
    init(_ model: CreateDeckRequestModel, _ token: String) {
        self.token = token
        body = .model(model)
    }
}
