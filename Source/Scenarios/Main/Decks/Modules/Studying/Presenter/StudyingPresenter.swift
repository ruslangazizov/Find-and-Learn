//
//  StudyingPresenter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import Foundation

protocol StudyingViewOutput: AnyObject {
    func endStudying()
}

final class StudyingPresenter: StudyingViewOutput {
    // MARK: Dependencies
    
    weak var view: StudyingViewInput?
    private let interactor: StudyingInteractorProtocol
    private let router: StudyingRouterProtocol
    
    // MARK: Init
    
    init(router: StudyingRouterProtocol, interactor: StudyingInteractorProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: StudyingViewOutput
    
    func endStudying() {
        router.goToPreviousModule()
    }
}
