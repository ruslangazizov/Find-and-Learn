//
//  StudyingAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import Foundation
import UIKit

final class StudyingAssembly: TransitionAssemblyProtocol {
    typealias DataModel = [Flashcard]
    
    static func assemble(with models: [Flashcard]) -> UIViewController {
        let interactor = StudyingInteractor(studyingManager: StudyingManager())
        let router = StudyingRouter()
        
        let presenter = StudyingPresenter(router: router, interactor: interactor)
        let viewController = StudyingViewController(presenter: presenter, cards: models)
        
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
