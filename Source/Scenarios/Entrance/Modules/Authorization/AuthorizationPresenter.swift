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
    
    init(interactor: AuthorizationInteractorProtocol) {
        self.interactor = interactor
    }
    
    // MARK: ViewOutput
    
    func enter(email: String, password: String) {
        interactor.enter(email: email, password: password) { result in
            switch result {
            case .emailTextField(let message):
                DispatchQueue.main.async {
                    self.view?.showError(.emailTextField(message))
                }
            case .passwordTextField(let message):
                DispatchQueue.main.async {
                    self.view?.showError(.passwordTextField(message))
                }
            case .success:
                // TODO: Routing
                print("OK")
            }
        }
    }
}
