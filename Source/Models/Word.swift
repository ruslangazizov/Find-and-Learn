//
//  Word.swift
//  Find-and-Learn
//
//  Created by Руслан on 19.03.2022.
//

import Foundation

struct Word {
    let word: String
    let detailTranslations: [Translation]?
    
    init(word: String, detailTranslations: [Translation]? = nil) {
        self.word = word
        self.detailTranslations = detailTranslations
    }
    
    init(_ wordEntity: WordEntity) {
        word = wordEntity.word
        detailTranslations = wordEntity.translations.map { Translation($0) }
    }
}

struct WordModel {
    let word: String
    let translations: String
    let detailTranslations: [Translation]?
    
    init(word: String, translations: String, detailTranslations: [Translation]? = nil) {
        self.word = word
        self.translations = translations
        self.detailTranslations = detailTranslations
    }
}

struct HistoryWord {
    let word: String
    let translations: [String]
    let dateAdded: Date
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
    var isFavorite: Bool
    let translations: [Translation]
}

struct Translation {
    let id: Int
    let translation: String
    let speechPart: String
    let transcription: String?
    let examples: [Example]
    
    init(
        id: Int,
        translation: String,
        speechPart: String,
        transcription: String?,
        examples: [Example]
    ) {
        self.id = id
        self.translation = translation
        self.speechPart = speechPart
        self.transcription = transcription
        self.examples = examples
    }
    
    init(_ translationEntity: TranslationEntity) {
        id = Int(translationEntity.id)
        translation = translationEntity.translation
        speechPart = translationEntity.speechPart
        transcription = translationEntity.transcription
        examples = translationEntity.examples.map { Example($0) }
    }
}

struct Example {
    let id: Int
    let example: String
    let translation: String?
    
    init(id: Int, example: String, translation: String?) {
        self.id = id
        self.example = example
        self.translation = translation
    }
    
    init(_ exampleEntity: ExampleEntity) {
        id = Int(exampleEntity.id)
        example = exampleEntity.example
        translation = exampleEntity.exampleTranslation
    }
}

struct WordDetailModel {
    let word: String
    var isFavorite: Bool
    var speechParts: [SpeechPartModel]
}

struct SpeechPartModel {
    let speechPart: String
    let transcription: String?
    var translations: [TranslationModel]
}

struct TranslationModel: Equatable {
    let translationWithSynonyms: String
    var isSelected = false
    let examples: [ExampleModel]
    
    init(_ translation: Translation) {
        translationWithSynonyms = translation.translation
        examples = translation.examples.map { ExampleModel($0) }
    }
}

struct ExampleModel: Equatable {
    let example: String
    let translation: String?
    
    init(_ example: Example) {
        self.example = example.example
        translation = example.translation
    }
}
