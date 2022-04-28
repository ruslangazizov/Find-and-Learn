//
//  StudyingManager.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import Foundation

protocol StudyingManagerProtocol: AnyObject {
    func logFlashCard(card: FlashcardModel) -> Bool
    func restart()
    func getLearnMoreCards() -> [FlashcardModel]
}

final class StudyingManager: StudyingManagerProtocol {
    // MARK: Properties
    
    private var learnMoreCards: [FlashcardModel] = []
    
    // MARK: StudyingManagerProtocol
    
    func logFlashCard(card: FlashcardModel) -> Bool {
        learnMoreCards.append(card)
        return learnMoreCards.count == 1
    }
    
    func restart() {
        learnMoreCards = []
    }
    
    func getLearnMoreCards() -> [FlashcardModel] {
        return learnMoreCards
    }
}
