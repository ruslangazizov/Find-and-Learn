//
//  DeleteDeckRequest.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 14.05.2022.
//

import Foundation

struct DeleteDeckRequest: Request {
    let method: HTTP.Method = .delete
    private(set) var path: String = "decks/"
    let token: String
    
    init(_ id: Int, _ token: String) {
        self.token = token
        path += "\(id)"
    }
}
