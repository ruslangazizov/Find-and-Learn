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
        let interactor = StudyingInteractor(studyingManager: StudyingManager())
        let router = StudyingRouter()
        
        let presenter = StudyingPresenter(router: router, interactor: interactor)
        let viewController = StudyingViewController(presenter: presenter)
        // TODO: delete when will be merge
        viewController.cards = [
            FlashCard(frontSide: "1", backSide: "1", comment: "1"),
            FlashCard(frontSide: "2", backSide: "2", comment: "2"),
            FlashCard(frontSide: "3", backSide: "3", comment: "3"),
            FlashCard(frontSide: "4", backSide: "4", comment: "4")
        ]
        
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
