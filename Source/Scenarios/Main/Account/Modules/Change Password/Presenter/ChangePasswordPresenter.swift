//
//  ChangePasswordPresenter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.04.2022.
//

import Foundation

protocol ChangePasswordViewOutput: AnyObject {
    func changePassword(password: String, confirmPassword: String)
}

final class ChangePasswordPresenter: ChangePasswordViewOutput {
    // MARK: Dependencies
    
    weak var view: ChangePasswordViewInput?
    private let interactor: ChangePasswordInteractorProtocol
    
    // MARK: Init
    
    init(interactor: ChangePasswordInteractorProtocol) {
        self.interactor = interactor
    }
    
    // MARK: ViewOutput
    func changePassword(password: String, confirmPassword: String) {
        interactor.changePassword(password: password, confirmPassword: confirmPassword) { result in
            switch result {
            case .password:
                view?.showError(.password(R.string.localizable.validation_error_incorrect_password()))
            case .confirmPassword:
                view?.showError(.confirmPassword(R.string.localizable.validation_error_password_not_equals()))
            case .success:
                // TODO: routing
                print(1)
            }
        }
    }
}
