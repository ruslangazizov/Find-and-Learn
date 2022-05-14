//
//  GetDecksRequest.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 14.05.2022.
//

import Foundation

struct GetDecksRequest: Request {
    let method: HTTP.Method = .get
    private(set) var path: String = "decks/"
    let token: String
    
    init(_ userID: Int, _ token: String) {
        self.token = token
        path += "\(userID)"
    }
}
