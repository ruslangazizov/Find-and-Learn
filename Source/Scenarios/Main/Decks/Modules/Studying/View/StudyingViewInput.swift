//
//  StudyingViewInput.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import Foundation

protocol StudyingViewInput: AnyObject {
    func showHasMistakesFinish()
    func continueLearning(cards: [FlashcardModel])
}
