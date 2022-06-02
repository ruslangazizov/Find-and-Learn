//
//  ConfirmEmailRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 02.06.2022.
//

import UIKit

protocol ConfirmEmailRouterProtocol: RouterProtocol {
    func showPreviousModule()
}

final class ConfirmEmailRouter: ConfirmEmailRouterProtocol {
    weak var view: UIViewController?
    
    func showPreviousModule() {
        view?.navigationController?.popViewController(animated: true)
    }
}
