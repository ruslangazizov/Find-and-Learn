//
//  RegistrationPresenter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 13.03.2022.
//

import Foundation

final class RegistrationPresenter: RegistrationViewOutput {
    // MARK: - Dependencies
    
    weak var view: RegistrationViewInput?
    private let interactor: RegistrationInteractorProtocol
    
    // MARK: Init
    
    init(interactor: RegistrationInteractorProtocol) {
        self.interactor = interactor
    }
}
