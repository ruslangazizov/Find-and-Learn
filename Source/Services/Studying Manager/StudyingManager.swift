//
//  StudyingManager.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import Foundation

protocol StudyingManagerProtocol: AnyObject {
    func logFlashCard(card: Flashcard) -> Bool
    func restart()
    func getLearnMoreCards() -> [Flashcard]
    func addLearnedCard(card: Flashcard)
    func getLearnedCards() -> [Flashcard]
}

final class StudyingManager: StudyingManagerProtocol {
    // MARK: Properties
    
    private var learnMoreCards: [Flashcard] = []
    
    private var learnedCards: [Flashcard] = []
    
    // MARK: StudyingManagerProtocol
    
    func logFlashCard(card: Flashcard) -> Bool {
        learnMoreCards.append(card)
        return learnMoreCards.count == 1
    }
    
    func restart() {
        learnMoreCards = []
    }
    
    func getLearnMoreCards() -> [Flashcard] {
        return learnMoreCards
    }
    
    func addLearnedCard(card: Flashcard) {
        learnedCards.append(card)
    }
    
    func getLearnedCards() -> [Flashcard] {
        return learnedCards
    }
}
