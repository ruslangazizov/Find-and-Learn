//
//  UpdateDeckRequest.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 14.05.2022.
//

import Foundation

struct UpdateDeckRequest: Request {
    let method: HTTP.Method = .put
    private(set) var path: String = "decks/"
    let token: String
    let body: HTTP.Body
    
    init(_ deckID: Int, _ token: String, _ name: String) {
        self.token = token
        path += "\(deckID)"
        body = .keyValue(["name": name])
    }
}
