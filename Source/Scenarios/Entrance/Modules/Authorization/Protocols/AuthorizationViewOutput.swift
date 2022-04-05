//
//  AuthorizationViewOutput.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 25.03.2022.
//

import Foundation

protocol AuthorizationViewOutput: AnyObject {
    func enter(email: String, password: String)
}
