//
//  DeleteRequest.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 09.05.2022.
//

import Foundation

struct DeleteRequest: Request {
    let method: HTTP.Method = .delete
    private(set) var path: String = "users/"
    let token: String
    
    init(_ id: Int, _ token: String) {
        self.token = token
        path += "\(id)"
    }
}
