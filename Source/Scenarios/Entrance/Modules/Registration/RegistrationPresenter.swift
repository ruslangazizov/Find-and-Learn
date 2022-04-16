//
//  RegistrationPresenter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 13.03.2022.
//

import Foundation

final class RegistrationPresenter: RegistrationViewOutput {
    // MARK: Dependencies
    
    weak var view: RegistrationViewInput?
    private let interactor: RegistrationInteractorProtocol
    private let router: RegistrationRouterProtocol
    
    // MARK: Init
    
    init(interactor: RegistrationInteractorProtocol, router: RegistrationRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: ViewOutput
    
    func registration(email: String, userName: String, password: String, confirmPassword: String) {
        interactor.registration(
            email: email,
            userName: userName,
            password: password,
            confirmPassword: confirmPassword) { [weak self] state in
                switch state {
                case .emailTextField(let message):
                    self?.view?.showError(.emailTextField(message))
                case .userNameTextField(let message):
                    self?.view?.showError(.userNameTextField(message))
                case .passwordTextField(let message):
                    self?.view?.showError(.passwordTextField(message))
                case .confirmPasswordTextField(let message):
                    self?.view?.showError(.confirmPasswordTextField(message))
                case .success:
                    self?.finish()
                }
        }
    }
    
    func enter() {
        router.showAuthorization()
    }
    
    private func finish() {
        router.finish()
    }
}
