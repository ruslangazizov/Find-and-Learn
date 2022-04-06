//
//  AuthorizationRouterProtocol.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 06.04.2022.
//

import Foundation

protocol AuthorizationRouterProtocol: AnyObject {
    func showRegistration()
    func showRecoveryPassword()
    func finish()
}