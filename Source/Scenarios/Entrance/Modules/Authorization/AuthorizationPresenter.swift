//
//  AuthorizationPresenter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 25.03.2022.
//

import Foundation

final class AuthorizationPresenter: AuthorizationViewOutput {
    // MARK: Dependencies
    
    weak var view: AuthorizationViewInput?
    private let interactor: AuthorizationInteractorProtocol
    
    // MARK: Init
    
    init (interactor: AuthorizationInteractorProtocol) {
        self.interactor = interactor
    }
}
