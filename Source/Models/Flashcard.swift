//
//  Flashcard.swift
//  Find-and-Learn
//
//  Created by Руслан on 27.04.2022.
//

import Foundation

struct NewFlashcardModel {
    var frontSide: String?
    var backSide: String?
    var deckIndex: Int?
    var comment: String?
    var createReversed = false
    
    init() { }
    
    init(
        frontSide: String?,
        backSide: String?,
        deckIndex: Int?,
        comment: String?,
        createReversed: Bool = false
    ) {
        self.frontSide = frontSide
        self.backSide = backSide
        self.deckIndex = deckIndex
        self.comment = comment
        self.createReversed = createReversed
    }
    
    init(_ flashcard: Flashcard) {
        frontSide = flashcard.frontSide
        backSide = flashcard.backSide
        comment = flashcard.comment
    }
}

struct NewFlashcard {
    let frontSide: String
    let backSide: String
    let deckId: Int
    let comment: String?
    let createReversed: Bool
}

struct Flashcard: Equatable {
    let id: Int
    let frontSide: String
    let backSide: String
    let comment: String?
    
    init(id: Int, frontSide: String, backSide: String, comment: String?) {
        self.id = id
        self.frontSide = frontSide
        self.backSide = backSide
        self.comment = comment
    }
    
    init(_ flashcardEntity: FlashcardEntity) {
        id = Int(flashcardEntity.id)
        frontSide = flashcardEntity.frontSide
        backSide = flashcardEntity.backSide
        comment = flashcardEntity.comment
    }
}
