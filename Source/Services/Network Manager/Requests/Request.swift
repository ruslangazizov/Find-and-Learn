//
//  Request.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 07.05.2022.
//

import Foundation

protocol Request {
    var method: HTTP.Method { get }
    var base: String { get }
    var path: String { get }
    var queries: HTTP.Queries { get }
    var body: HTTP.Body { get }
    var token: String { get }
}

extension Request {
    var base: String {
        "https://find-and-learn-web.herokuapp.com/"
    }
    
    var queries: HTTP.Queries {
        [:]
    }
    
    var body: HTTP.Body {
        .none
    }
    
    var token: String {
        ""
    }
}
