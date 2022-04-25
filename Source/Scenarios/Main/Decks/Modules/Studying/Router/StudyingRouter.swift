//
//  StudyingRouter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import Foundation
import UIKit

protocol StudyingRouterProtocol: RouterProtocol {
    func goToPreviousModule()
}

final class StudyingRouter: StudyingRouterProtocol {
    // MARK: Dependencies
    
    weak var view: UIViewController?
    
    // MARK: StudyingRouterProtocol
    
    func goToPreviousModule() {
        view?.navigationController?.popViewController(animated: true)
    }
}
