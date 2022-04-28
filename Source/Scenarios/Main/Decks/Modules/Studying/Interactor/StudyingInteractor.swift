//
//  StudyingInteractorProtocol.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import Foundation

protocol StudyingInteractorProtocol: AnyObject {
    func getLearnMoreWords(_ completion: ([FlashcardModel]) -> Void)
    func studyMoreCard(card: FlashcardModel, _ completion: () -> Void)
    func restartManager()
}

final class StudyingInteractor: StudyingInteractorProtocol {
    // MARK: Dependencies
    
    private let studyingManager: StudyingManagerProtocol
    
    // MARK: Init
    
    init(studyingManager: StudyingManagerProtocol) {
        self.studyingManager = studyingManager
    }
    
    // MARK: StudyingInteractorProtocol
    
    func getLearnMoreWords(_ completion: ([FlashcardModel]) -> Void) {
        completion(studyingManager.getLearnMoreCards())
    }
    
    // Вызывается completion, если был добавлен первый элемент == пользователь не вспомнил слово
    func studyMoreCard(card: FlashcardModel, _ completion: () -> Void) {
        if studyingManager.logFlashCard(card: card) {
            completion()
        }
    }
    
    func restartManager() {
        studyingManager.restart()
    }
}
