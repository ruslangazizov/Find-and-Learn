//
//  HTTPMethod+Extensions.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 07.05.2022.
//

import Foundation
import Alamofire

extension HTTPMethod {
    init(_ method: HTTP.Method) {
        self.init(rawValue: method.rawValue)
    }
}
