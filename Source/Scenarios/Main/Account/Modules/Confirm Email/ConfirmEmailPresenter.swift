//
//  ConfirmEmailPresenter.swift
//  Find-and-Learn
//
//  Created by Руслан on 02.06.2022.
//

import Foundation

protocol ConfirmEmailViewOutput: AnyObject {
    func didTapButton(with code: String?)
}

final class ConfirmEmailPresenter: ConfirmEmailViewOutput {
    // MARK: Dependencies
    
    weak var view: ConfirmEmailViewInput?
    
    private let interactor: ConfirmEmailInteractorProtocol
    
    private let router: ConfirmEmailRouterProtocol
    
    // MARK: Init
    
    init(interactor: ConfirmEmailInteractorProtocol, router: ConfirmEmailRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: ConfirmEmailViewOutput
    
    func didTapButton(with text: String?) {
        guard let text = text, !text.isEmpty, let code = Int(text) else {
            view?.showErrorAlert()
            return
        }
        
        if interactor.checkEmailConfirmationCode(code) {
            NotificationCenter.default.post(name: .didConfirmEmail, object: nil)
            view?.showSuccessAlert {
                self.router.showPreviousModule()
            }
        } else {
            view?.showErrorAlert()
        }
    }
}
