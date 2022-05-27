//
//  PopularWordsRequest.swift
//  Find-and-Learn
//
//  Created by Руслан on 27.05.2022.
//

import Foundation

final class PopularWordsRequest: Request {
    let method: HTTP.Method = .get
    let path: String = "words/starter_pack"
    let token: String
    
    init(_ token: String) {
        self.token = token
    }
}
