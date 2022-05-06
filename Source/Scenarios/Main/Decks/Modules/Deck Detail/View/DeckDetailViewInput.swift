//
//  DeckDetailViewInput.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import Foundation

protocol DeckDetailViewInput: AnyObject {
    func showFlashcards(_ models: [Flashcard])
    func setStudyButtonIsEnabled(_ isEnabled: Bool)
}
