//
//  StudyingAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import Foundation
import UIKit

final class StudyingAssembly: AssemblyProtocol {
    static func assemble() -> UIViewController {
        let interactor = StudyingInteractor()
        let router = StudyingRouter()
        
        let presenter = StudyingPresenter(router: router, interactor: interactor)
        let viewController = StudyingViewController(presenter: presenter)
        
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
