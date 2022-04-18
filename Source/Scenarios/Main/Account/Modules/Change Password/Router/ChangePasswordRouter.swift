//
//  ChangePasswordRouter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.04.2022.
//

import Foundation
import UIKit

protocol ChangePasswordRouterProtocol: RouterProtocol {
    func showPreviousModule()
}

final class ChangePasswordRouter: ChangePasswordRouterProtocol {
    // MARK: Dependencies
    
    weak var view: UIViewController?
    
    // MARK: ChangePasswordRouterProtocol
    
    func showPreviousModule() {
        view?.navigationController?.popViewController(animated: true)
    }
}
