//
//  StudyingInteractorProtocol.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import Foundation

protocol StudyingInteractorProtocol: AnyObject {
    func getLearnMoreWords(_ completion: ([Flashcard]) -> Void)
    func studyMoreCard(card: Flashcard, _ completion: () -> Void)
    func restartManager()
    func saveActionWithCard(card: Flashcard, action: CardAction)
}

final class StudyingInteractor: StudyingInteractorProtocol {
    // MARK: Dependencies
    
    private let studyingManager: StudyingManagerProtocol
    
    private let flashcardsRepository: FlashcardsRepositoryProtocol
    
    // MARK: Init
    
    init(studyingManager: StudyingManagerProtocol, flashcardsRepository: FlashcardsRepositoryProtocol) {
        self.studyingManager = studyingManager
        self.flashcardsRepository = flashcardsRepository
    }
    
    // MARK: StudyingInteractorProtocol
    
    func getLearnMoreWords(_ completion: ([Flashcard]) -> Void) {
        completion(studyingManager.getLearnMoreCards())
    }
    
    // Вызывается completion, если был добавлен первый элемент == пользователь не вспомнил слово
    func studyMoreCard(card: Flashcard, _ completion: () -> Void) {
        if studyingManager.logFlashCard(card: card) {
            completion()
        }
    }
    
    func restartManager() {
        studyingManager.restart()
    }
    
    func saveActionWithCard(card: Flashcard, action: CardAction) {
        flashcardsRepository.addFlashcardAction(flashcardId: card.id, action: action)
    }
}
