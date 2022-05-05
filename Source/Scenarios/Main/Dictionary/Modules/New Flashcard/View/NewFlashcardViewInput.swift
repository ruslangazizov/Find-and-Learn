//
//  NewFlashcardViewInput.swift
//  Find-and-Learn
//
//  Created by Руслан on 29.04.2022.
//

import Foundation

protocol NewFlashcardViewInput: AnyObject {
    func setDecks(_ decks: [String])
    func showEmptyFrontOrBackSideAlert()
    func showNoDeckChosenAlert()
    func setCurrentDeck(index: Int)
}
