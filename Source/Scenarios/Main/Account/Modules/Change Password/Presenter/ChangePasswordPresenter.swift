//
//  ChangePasswordPresenter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.04.2022.
//

import Foundation

protocol ChangePasswordViewOutput: AnyObject {
}

final class ChangePasswordPresenter: ChangePasswordViewOutput {
    // MARK: Dependencies
    
    weak var view: ChangePasswordViewInput?
    private let interactor: ChangePasswordInteractorProtocol
    
    // MARK: Init
    
    init(interactor: ChangePasswordInteractorProtocol) {
        self.interactor = interactor
    }
}
