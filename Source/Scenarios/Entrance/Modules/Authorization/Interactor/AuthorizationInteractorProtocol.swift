//
//  AuthorizationInteractorProtocol.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 05.04.2022.
//

import Foundation

protocol AuthorizationInteractorProtocol: AnyObject {
    func enter(email: String, password: String, _ result: (AuthorizationResultState) -> Void)
}
