//
//  Flashcard.swift
//  Find-and-Learn
//
//  Created by Руслан on 27.04.2022.
//

import Foundation

struct FlashcardModel {
	let frontSide: String
	let backSide: String
	let comment: String?
}

struct NewFlashcardModel {
    var frontSide: String?
    var backSide: String?
    var deckIndex: Int?
    var comment: String?
    var createReversed = false
    
    init(_ flashcardModel: FlashcardModel?) {
        frontSide = flashcardModel?.frontSide
        backSide = flashcardModel?.backSide
        comment = flashcardModel?.comment
    }
}

struct NewFlashcard {
    var frontSide: String
    var backSide: String
    var deckId: Int
    var comment: String?
    var createReversed: Bool
}

struct Deck {
    let id: Int
    let name: String
    let createdAt: Date
}
