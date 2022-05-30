//
//  WordsRepository.swift
//  Find-and-Learn
//
//  Created by Руслан on 18.05.2022.
//

import Foundation

final class WordsRepository: WordsRepositoryProtocol {
    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func getWords(_ wordPart: String, completion: @escaping ([Word]) -> Void) {
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "word CONTAINS[c] %@", wordPart)
        coreDataManager.fetch(fetchRequest) { wordsEntities in
            completion(wordsEntities?.map { Word($0) } ?? [])
        }
    }
    
    func saveWord(_ word: Word) {
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "word == %@", word.word)
        
        coreDataManager.fetch(fetchRequest) { [weak self] wordsEntities in
            guard let self = self, wordsEntities?.first == nil else { return }
            
            self.coreDataManager.contextProvider { context in
                let wordId = Int.random(in: 1...1_000_000)
                let wordEntity = WordEntity(
                    context: context,
                    word: word.word,
                    id: self.coreDataManager.getAvailableId(initialId: wordId, for: WordEntity.self)
                )
                word.detailTranslations?.forEach { translation in
                    let translationId = self.coreDataManager.getAvailableId(
                        initialId: translation.id, for: TranslationEntity.self
                    )
                    let translationEntity = TranslationEntity(
                        context: context,
                        transcription: translation.transcription,
                        speechPart: translation.speechPart,
                        translation: translation.translation,
                        id: translationId,
                        word: wordEntity
                    )
                    translation.examples.forEach { example in
                        _ = ExampleEntity(
                            context: context,
                            id: self.coreDataManager.getAvailableId(initialId: example.id, for: ExampleEntity.self),
                            translationId: translationId,
                            example: example.example,
                            exampleTranslation: example.translation,
                            translation: translationEntity
                        )
                    }
                }
            }
        }
    }
    
    func fetchHistoryWords(completion: @escaping ([HistoryWord]) -> Void) {
        let fetchRequest = HistoryWordEntity.fetchRequest()
        coreDataManager.fetch(fetchRequest) { historyWordsEntities in
            completion(historyWordsEntities?.map { historyWordEntity in
                HistoryWord(
                    word: historyWordEntity.word.word,
                    translations: historyWordEntity.word.translations.map { $0.translation },
                    dateAdded: historyWordEntity.timeOpened
                )
            } ?? [])
        }
    }
    
    func addHistoryWord(wordId: Int, timeOpened: Date, completion: ((Bool) -> Void)?) {
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", wordId)
        coreDataManager.fetch(fetchRequest) { [weak self] wordsEntities in
            guard let wordEntity = wordsEntities?.first else {
                completion?(false)
                return
            }
            self?.coreDataManager.contextProvider { context in
                _ = HistoryWordEntity(
                    context: context,
                    wordId: wordId,
                    timeOpened: timeOpened,
                    word: wordEntity
                )
                completion?(true)
            }
        }
    }
    
    func fetchFavoriteWords(completion: @escaping ([Word]) -> Void) {
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isFavorite == %c", true)
        coreDataManager.fetch(fetchRequest) { wordsEntities in
            completion(wordsEntities?.map { Word($0) } ?? [])
        }
    }
    
    func fetchWordDetail(_ word: String, completion: @escaping (WordDetail?) -> Void) {
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "word == %@", word)
        coreDataManager.fetch(fetchRequest) { wordsEntities in
            let wordEntity = wordsEntities?.first
            completion(wordEntity.map { WordDetail($0) })
        }
    }
    
    func changeWordStatus(_ wordId: Int, isFavorite: Bool) {
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld", wordId)
        coreDataManager.mutate(fetchRequest) { wordsEntities in
            let wordEntity = wordsEntities?.first
            wordEntity?.isFavorite = isFavorite
        }
    }
}
