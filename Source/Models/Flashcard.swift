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
    let frontSide: String
    let backSide: String
    let deckId: Int
    let comment: String?
    let createReversed: Bool
}

// TODO: есть идея везде заменить FlashcardModel на Flashcard, т.к. часто нужно будет знать id карточки
struct Flashcard {
    let id: Int
    let frontSide: String
    let backSide: String
    let comment: String?
}
