//
//  ChangePasswordInteractor.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.04.2022.
//

import Foundation

protocol ChangePasswordInteractorProtocol: AnyObject {
    func changePassword(
        password: String,
        confirmPassword: String,
        _ result: @escaping (ChangePasswordResultState) -> Void
    )
}

final class ChangePasswordInteractor: ChangePasswordInteractorProtocol {
    // MARK: Dependencies
    
    private let validationManager: ValidationManagerProtocol
    private let networkManager: NetworkManagerProtocol
    private let userManager: UserManagerProtocol
    private let tokensManager: TokensManagerProtocol
    
    // MARK: Init
    
    init(
        validationManager: ValidationManagerProtocol,
        networkManager: NetworkManagerProtocol,
        userManager: UserManagerProtocol,
        tokensManager: TokensManagerProtocol
    ) {
        self.validationManager = validationManager
        self.networkManager = networkManager
        self.userManager = userManager
        self.tokensManager = tokensManager
    }
    
    // MARK: ChangePasswordInteractorProtocol
    
    func changePassword(
        password: String,
        confirmPassword: String,
        _ result: @escaping (ChangePasswordResultState) -> Void
    ) {
        if !validationManager.isValidPassword(password) {
            result(.password)
        } else if password != confirmPassword {
            result(.confirmPassword)
        } else {
            let user = userManager.getUser()
            guard let token = tokensManager.getToken() else {
                return
            }
            let request = UserUpdateRequest(
                .init(
                    firstName: "",
                    secondName: "",
                    userName: user.userName,
                    password: password
                ),
                user.id,
                token
            )
            networkManager.perform(request) { resultData in
                switch resultData {
                case .success:
                    result(.success)
                case .failure:
                    result(.password)
                }
            }
        }
    }
}
