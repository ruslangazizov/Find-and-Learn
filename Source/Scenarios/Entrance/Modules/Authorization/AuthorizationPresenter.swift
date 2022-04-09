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
    private let router: AuthorizationRouterProtocol
    
    // MARK: Init
    
    init(interactor: AuthorizationInteractorProtocol, router: AuthorizationRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: ViewOutput
    
    func enter(email: String, password: String) {
        DispatchQueue.global(qos: .utility).async {
            self.interactor.enter(email: email, password: password) { [weak self] result in
                switch result {
                case .emailTextField(let message):
                    DispatchQueue.main.async {
                        self?.view?.showError(.email(message))
                    }
                case .passwordTextField(let message):
                    DispatchQueue.main.async {
                        self?.view?.showError(.password(message))
                    }
                case .success:
                    self?.finish()
                }
            }
        }
    }
    
    func enterAsGuest() {
        self.router.finishFlow()
    }
    
    func resetPassword() {
        self.router.showRecoveryPasswordModule()
    }
    
    func registration() {
        self.router.showRegistrationModule()
    }
    
    private func finish() {
        self.router.finishFlow()
    }
}
