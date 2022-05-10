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
        view?.startLoader()
        interactor.enter(email: email, password: password) { [weak self] result in
            self?.view?.stopLoader()
            switch result {
            case .emailTextField(let message):
                self?.view?.showError(.email(message))
            case .passwordTextField(let message):
                self?.view?.showError(.password(message))
            case .success:
                self?.finish()
            }
        }
    }
    
    func enterAsGuest() {
        router.finishFlow()
    }
    
    func resetPassword() {
        router.showRecoveryPasswordModule()
    }
    
    func registration() {
        router.showRegistrationModule()
    }
    
    private func finish() {
        router.finishFlow()
    }
}
