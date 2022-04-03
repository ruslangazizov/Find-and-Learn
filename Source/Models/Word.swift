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

    var translationsString: String {
        return translations.joined(separator: ", ")
    }
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
