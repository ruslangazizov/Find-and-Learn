//
//  Deck.swift
//  Find-and-Learn
//
//  Created by Руслан on 30.04.2022.
//

import Foundation

struct Deck: Equatable {
    let id: Int
    let name: String
    let createdAt: Date
    var flashcards: [Flashcard]?
}

struct DeckModel {
    let name: String
    let flashcardsCountString: String?
}
