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
    func checkAchievement(totalCardCount: Int)
}

final class StudyingInteractor: StudyingInteractorProtocol {
    // MARK: Dependencies
    
    private let studyingManager: StudyingManagerProtocol
    
    private let flashcardsRepository: FlashcardsRepositoryProtocol
    
    private let achievementsManager: AchievementsManagerProtocol
    
    // MARK: Init
    
    init(
        studyingManager: StudyingManagerProtocol,
        flashcardsRepository: FlashcardsRepositoryProtocol,
        achievementsManager: AchievementsManagerProtocol
    ) {
        self.studyingManager = studyingManager
        self.flashcardsRepository = flashcardsRepository
        self.achievementsManager = achievementsManager
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
        if action == .learned {
            studyingManager.addLearnedCard(card: card)
        }
    }
    
    func checkAchievement(totalCardCount: Int) {
        if totalCardCount == studyingManager.getLearnedCards().count && totalCardCount >= 10 {
            achievementsManager.addTinaKandelakiAchievement()
        }
    }
}
