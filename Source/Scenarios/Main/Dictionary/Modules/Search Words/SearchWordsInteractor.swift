//
//  SearchWordsInteractor.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import Foundation

protocol SearchWordsInteractorProtocol: AnyObject {
    func getWords(_ word: String?, completion: @escaping ([Word]) -> Void)
}

final class SearchWordsInteractor: SearchWordsInteractorProtocol {
    // MARK: Dependencies
    
    private let tokensManager: TokensManagerProtocol
    private let networkManager: NetworkManagerProtocol
    private let validationManager: ValidationManagerProtocol
    private let wordsRepository: WordsRepositoryProtocol
    
    // MARK: Initializer
    
    init(
        tokensManager: TokensManagerProtocol,
        networkManager: NetworkManagerProtocol,
        validationManager: ValidationManagerProtocol,
        wordsRepository: WordsRepositoryProtocol
    ) {
        self.tokensManager = tokensManager
        self.networkManager = networkManager
        self.validationManager = validationManager
        self.wordsRepository = wordsRepository
    }
    
    // MARK: SearchWordsInteractorProtocol
    
    func getWords(_ word: String?, completion: @escaping ([Word]) -> Void) {
        guard let word = word?.trimmingCharacters(in: .whitespacesAndNewlines),
            word.count > 1 else {
            return
        }
        
        wordsRepository.getWords(word) { [weak self] words in
            if !words.isEmpty {
                completion(words)
                return
            }
            
            guard let self = self, let apiKey = self.tokensManager.getApiKey() else { return }
            let request = DictionaryRequest(word, apiKey, self.validationManager.areEnglishCharacters(word))
            
            self.networkManager.perform(request) { (result: Result<DictionaryResponseModel, NetworkManagerError>) in
                switch result {
                case .success(let model):
                    if model.body.isEmpty {
                        completion([])
                        return
                    }
                    
                    let word = model.asWord()
                    self.wordsRepository.saveWord(word)
                    completion([word])
                case .failure(let error):
                    print(error)
                    completion([])
                }
            }
        }
    }
}

private struct DictionaryResponseModel: Decodable {
    let body: [WordResponseModel]
    
    enum CodingKeys: String, CodingKey {
        case body = "def"
    }
    
    func asWord() -> Word {
        return Word(
            word: body.first?.text ?? "",
            detailTranslations: body.flatMap { wordModel in
                wordModel.translations.map {
                    Translation(
                        id: Int.random(in: 1...1_000_000),
                        translation: $0.text,
                        speechPart: $0.pos,
                        transcription: wordModel.transcription,
                        examples: $0.examples?.map { example in
                            Example(
                                id: Int.random(in: 1...1_000_000),
                                example: example.text,
                                translation: example.translations.first?.text)
                        } ?? []
                    )
                }
            }
        )
    }
}

private struct WordResponseModel: Decodable {
    let text: String
    let pos: String?
    let transcription: String?
    let translations: [TranslationResponseModel]
    
    enum CodingKeys: String, CodingKey {
        case text
        case pos
        case transcription = "ts"
        case translations = "tr"
    }
}

private struct TranslationResponseModel: Decodable {
    let text: String
    let pos: String
    let examples: [ExampleResponseModel]?
    
    enum CodingKeys: String, CodingKey {
        case text
        case pos
        case examples = "ex"
    }
}

private struct ExampleResponseModel: Decodable {
    let text: String
    let translations: [MeaningResponseModel]
    
    enum CodingKeys: String, CodingKey {
        case text
        case translations = "tr"
    }
}

private struct MeaningResponseModel: Decodable {
    let text: String
}
