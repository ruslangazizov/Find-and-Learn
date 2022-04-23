//
//  StudyingManager.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import Foundation

protocol StudyingManagerProtocol: AnyObject {
    func logFlashCard(card: FlashCard) -> Bool
    func restart()
    func getLearnMoreCards() -> [FlashCard]
}

final class StudyingManager: StudyingManagerProtocol {
    // MARK: Properties
    
    private var learnMoreCards: [FlashCard] = []
    
    // MARK: StudyingManagerProtocol
    
    func logFlashCard(card: FlashCard) -> Bool {
        learnMoreCards.append(card)
        return learnMoreCards.count == 1
    }
    
    func restart() {
        learnMoreCards = []
    }
    
    func getLearnMoreCards() -> [FlashCard] {
        return learnMoreCards
    }
}
