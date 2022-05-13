//
//  DataManagerMock.swift
//  Find-and-Learn
//
//  Created by Руслан on 31.03.2022.
//

import CoreData

final class DataManagerMock: DataManagerProtocol {
    static let shared: DataManagerProtocol = DataManagerMock()
    
    private init() {}
    
    // MARK: Core Data stack
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Find_and_Learn")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    private lazy var viewContext = persistentContainer.viewContext
    
    // MARK: Core Data Saving support
    
    private func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func checkId(_ objectId: Int, entityType: NSManagedObject.Type) -> Bool {
        let fetchRequest = entityType.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", objectId)
        do {
            let object = try viewContext.fetch(fetchRequest).first
            return object == nil
        } catch {
            return false
        }
    }
}

// MARK: - Public methods

extension DataManagerMock {
    func getWords(_ wordPart: String, completion: ([Word]) -> Void) {
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "word CONTAINS[c] %@", wordPart)
        do {
            let wordsEntities = try viewContext.fetch(fetchRequest)
            completion(wordsEntities.map { Word($0) })
        } catch {
            completion([])
        }
    }
    
    func saveWord(_ word: Word) {
        let wordEntity = WordEntity(context: viewContext, word: word.word)
        wordEntity.translations = Set(word.detailTranslations?.map { translation in
            let translationId = checkId(
                translation.id, entityType: TranslationEntity.self
            ) ? translation.id : Int.random(in: 1...1_000_000)
            let translationEntity = TranslationEntity(
                context: viewContext,
                transcription: translation.transcription,
                speechPart: translation.speechPart,
                translation: translation.translation,
                id: translationId,
                word: wordEntity
            )
            translationEntity.examples = Set(translation.examples.map { example in
                let exampleId = checkId(
                    example.id, entityType: ExampleEntity.self
                ) ? example.id : Int.random(in: 1...1_000_000)
                return ExampleEntity(
                    context: viewContext,
                    id: exampleId,
                    translationId: translationId,
                    example: example.example,
                    exampleTranslation: example.translation,
                    translation: translationEntity
                )
            })
            return translationEntity
        } ?? [])
        saveContext()
    }
    
    func fetchHistoryWords(completion: ([HistoryWord]) -> Void) {
        let fetchRequest = HistoryWordEntity.fetchRequest()
        do {
            let historyWordsEntities = try viewContext.fetch(fetchRequest)
            completion(historyWordsEntities.map { historyWordEntity in
                HistoryWord(
                    word: historyWordEntity.word.word,
                    translations: historyWordEntity.word.translations.map { $0.translation },
                    dateAdded: historyWordEntity.timeOpened
                )
            })
        } catch {
            completion([])
        }
    }
    
    func addHistoryWord(wordId: Int, timeOpened: Date, completion: ((Bool) -> Void)?) {
        let fetchRequest = WordEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", wordId)
        do {
            let wordEntity = try viewContext.fetch(fetchRequest).first
            guard let wordEntity = wordEntity else {
                completion?(false)
                return
            }
            _ = HistoryWordEntity(
                context: viewContext,
                wordId: wordId,
                timeOpened: timeOpened,
                word: wordEntity
            )
            saveContext()
            completion?(true)
        } catch {
            completion?(false)
        }
    }
    
    func fetchFavoriteWords(completion: ([Word]) -> Void) {
    }
    
    func fetchWordDetail(_ word: String, completion: @escaping (WordDetail) -> Void) {
        completion(WordDetail(id: 1, word: "break", isFavorite: false, translations: [
            Translation(
                id: 1,
                translation: "перерыв",
                speechPart: "существительное",
                transcription: "breɪk",
                examples: [
                    Example(id: 1, example: "We work without a break.", translation: "Мы работаем без перерыва."),
                    Example(id: 2, example: "Do you need a break?", translation: "Нужен ли тебе перерыв?")
                ]
            ),
            Translation(
                id: 2,
                translation: "разрыв",
                speechPart: "существительное",
                transcription: "breɪk",
                examples: [
                    Example(id: 4, example: "break in the pipe-line", translation: "разрыв трубопровода"),
                    Example(id: 5, example: "text break", translation: "разрыв текста"),
                    Example(id: 6, example: "break in relations", translation: "разрыв отношений")
                ]
            ),
            Translation(
                id: 3,
                translation: "ломать",
                speechPart: "глагол",
                transcription: "breɪk",
                examples: [
                    Example(id: 7, example: "to break in two", translation: "разломить, сломать пополам"),
                    Example(id: 8, example: "to break one's leg", translation: "сломать ногу")
                ]
            )
        ]))
    }
    
    func changeWordStatus(_ wordId: Int, isFavorite: Bool) {
    }
    
    func fetchDecks(includeFlashcards: Bool, completion: @escaping ([Deck]) -> Void) {
        DispatchQueue.global().async {
            let flashcards = !includeFlashcards ? nil : [
                Flashcard(
                    id: 34875,
                    frontSide: "Передняя сторона 1",
                    backSide: "Задняя сторона 1",
                    comment: "Suspendisse ut neque at urna fermentum accumsan sit amet eget felis"
                ),
                Flashcard(
                    id: 835761,
                    frontSide: "Передняя сторона 2",
                    backSide: "Задняя сторона 2",
                    comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
                ),
                Flashcard(
                    id: 435738,
                    frontSide: "Передняя сторона 3",
                    backSide: "Задняя сторона 3",
                    comment: "In id aliquet magna, sed rutrum justo"
                )
            ]
            completion([
                Deck(
                    id: 5432134,
                    name: "Колода 1",
                    createdAt: .init(timeInterval: -1800, since: Date()),
                    flashcards: flashcards
                ),
                Deck(
                    id: 7624853,
                    name: "Колода 2",
                    createdAt: .init(timeInterval: -1200, since: Date()),
                    flashcards: flashcards
                ),
                Deck(
                    id: 3124786,
                    name: "Колода 3",
                    createdAt: .init(timeInterval: -600, since: Date()),
                    flashcards: flashcards
                )
            ])
        }
    }
    
    func saveNewFlashcard(_ newFlashcard: NewFlashcard) {
    }
    
    func deleteDeck(deckId: Int) {
    }
    
    func createDeck(name: String, completion: @escaping (Deck) -> Void) {
        DispatchQueue.global().async {
            completion(Deck(id: UUID().hashValue, name: name, createdAt: Date(), flashcards: []))
        }
    }
    
    func deleteFlashcard(flashcardId: Int) {
    }
    
    func fetchFlashcards(deckId: Int, completion: @escaping ([Flashcard]?) -> Void) {
        fetchDecks(includeFlashcards: true) { decks in
            completion(decks.first { $0.id == deckId }?.flashcards)
        }
    }
    
    func updateFlashcard(_ flashcard: Flashcard, updatedDeckId: Int) {
    }
    
    func saveEmailCode(_ code: Int) {
    }
    
    func saveToken(_ token: String) {
    }
    
    func getToken() -> String? {
        return nil
    }
    
    func getApiKey() -> String? {
        return "dict.1.1.20220509T162427Z.6fc4e65140e1e3dc.6be551b61e08e1351dce814bb39a1f6e6fb58573"
    }
}
