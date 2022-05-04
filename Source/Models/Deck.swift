//
//  Deck.swift
//  Find-and-Learn
//
//  Created by Руслан on 30.04.2022.
//

import Foundation

struct Deck {
    let id: Int
    let name: String
    let createdAt: Date
    let flashcards: [Flashcard]?
}

struct DeckModel {
    let name: String
    let flashcardsCountString: String?
}
