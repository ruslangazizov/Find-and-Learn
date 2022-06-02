//
//  StudyingPresenter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import Foundation

protocol StudyingViewOutput: AnyObject {
    func actionWithCard(card: Flashcard, action: CardAction)
    func continueLearning()
    func restart()
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
    
    func actionWithCard(card: Flashcard, action: CardAction) {
        if action == .studyMore {
            interactor.studyMoreCard(card: card) {
                view?.showHasMistakesFinish()
            }
        }
        interactor.saveActionWithCard(card: card, action: action)
    }
    
    func continueLearning() {
        interactor.getLearnMoreWords { cards in
            view?.continueLearning(cards: cards.shuffled())
        }
        interactor.restartManager()
    }
    
    func restart() {
        interactor.restartManager()
    }
    
    func endStudying() {
        router.goToPreviousModule()
    }
}
