//
//  RegistrationInteractor.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 05.04.2022.
//

import Foundation

protocol RegistrationInteractorProtocol: AnyObject {
    func registration(
        email: String,
        userName: String,
        password: String,
        confirmPassword: String,
        _ result: @escaping (RegistrationResultState) -> Void
    )
}

final class RegistrationInteractor: RegistrationInteractorProtocol {
    // MARK: Dependencies
    
    private let validationManager: ValidationManagerProtocol
    private let networkManager: NetworkManagerProtocol
    private let userManager: UserManagerProtocol
    private let dataManager: DataManagerProtocol
    
    // MARK: Init
    
    init(
        validationManager: ValidationManagerProtocol,
        networkManager: NetworkManagerProtocol,
        userManager: UserManagerProtocol,
        dataManager: DataManagerProtocol
    ) {
        self.validationManager = validationManager
        self.networkManager = networkManager
        self.userManager = userManager
        self.dataManager = dataManager
    }
    
    // MARK: RegistrationInteractorProtocol
    
    func registration(
        email: String,
        userName: String,
        password: String,
        confirmPassword: String,
        _ result: @escaping (RegistrationResultState) -> Void
    ) {
        guard !email.isEmpty else {
            result(.emailTextField(R.string.localizable.validation_error_empty_email()))
            return
        }
        
        if !validationManager.isValidEmail(email) {
            result(.emailTextField(R.string.localizable.validation_error_incorrect_email()))
        } else if !validationManager.isValidUserName(userName) {
            result(.userNameTextField(R.string.localizable.validation_error_incorrect_user_name()))
        } else if !validationManager.isValidPassword(password) {
            result(.passwordTextField(R.string.localizable.validation_error_incorrect_password()))
        } else if password != confirmPassword {
            result(.confirmPasswordTextField(R.string.localizable.validation_error_password_not_equals()))
        } else {
            let requestModel = CreateRequestModel(
                firstName: "",
                secondName: "",
                email: email,
                password: password,
                registeredAt: Date().toString(using: .registrationDateFormatter)
            )
            networkManager.perform(
                CreateRequest(requestModel)
            ) { [weak self] (resultData: Result<RegistrationResponseModel, NetworkManagerError>) in
                switch resultData {
                case .success(let model):
                    DispatchQueue.global(qos: .background).async {
                        self?.userManager.saveEmailCode(model.emailCode)
                        self?.userManager.saveUser(User(
                            email: email,
                            userName: userName,
                            password: password,
                            state: .inactive)
                        )
                        self?.dataManager.saveToken("\(HTTP.Auth.tokenType) \(model.token)")
                    }
                    result(.success)
                case .failure:
                    result(.emailTextField(R.string.localizable.validation_error_not_unique_email()))
                }
            }
        }
    }
}

private struct RegistrationResponseModel: Decodable {
    let id: Int
    let firstName: String
    let secondName: String
    let email: String
    let emailCode: Int
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case secondName = "second_name"
        case email
        case emailCode = "email_confirmation_code"
        case token
    }
}
