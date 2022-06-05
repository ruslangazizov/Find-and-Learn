//
//  HTTPMethod+Extensions.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 07.05.2022.
//

import Foundation
import Alamofire

// TODO: (r.akhmadeev) Используется только в одном месте. Логичнее было бы сделать приватным и перенести в тот файл, где используется
extension HTTPMethod {
    init(_ method: HTTP.Method) {
        self.init(rawValue: method.rawValue)
    }
}
