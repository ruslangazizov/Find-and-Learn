//
//  Word.swift
//  Find-and-Learn
//
//  Created by Руслан on 19.03.2022.
//

import Foundation

struct Word {
    let word: String
    let translations: [String]
}

struct WordModel {
    let word: String
    let translations: String
}

struct HistoryWord {
    let word: String
    let translations: [String]
    let dateAdded: Date
    let searchesCount: Int
}

struct HistoryWordModel {
    let word: String
    let translations: String
    let searchesCount: Int
}

struct HistoryWordsSection {
    let title: String
    let words: [HistoryWordModel]
}

struct WordDetail {
    let id: Int
    let word: String
    let translations: [Translation]
}

struct Translation {
    let id: Int
    let translation: String
    let speechPart: String
    let transcription: String?
    let examples: [Example]
}

struct Example {
    let id: Int
    let example: String
    let translation: String?
}
