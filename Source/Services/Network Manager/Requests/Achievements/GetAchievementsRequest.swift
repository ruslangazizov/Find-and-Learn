//
//  GetAchievementsRequest.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 14.05.2022.
//

import Foundation

struct GetAchievementsRequest: Request {
    let method: HTTP.Method = .get
    private(set) var path: String = "achievements/"
    let token: String
    
    init(_ userID: Int, _ token: String) {
        self.token = token
        path += "\(userID)"
    }
}
