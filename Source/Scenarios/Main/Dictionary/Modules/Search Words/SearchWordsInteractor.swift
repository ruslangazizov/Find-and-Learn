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
    
    // MARK: Initializer
    
    init(
        tokensManager: TokensManagerProtocol,
        networkManager: NetworkManagerProtocol,
        validationManager: ValidationManagerProtocol
    ) {
        self.tokensManager = tokensManager
        self.networkManager = networkManager
        self.validationManager = validationManager
    }
    
    // MARK: SearchWordsInteractorProtocol
    
    func getWords(_ word: String?, completion: @escaping ([Word]) -> Void) {
        guard let word = word,
            word.trimmingCharacters(in: .whitespacesAndNewlines).count > 1 else {
            return
        }
        
        guard let apiKey = tokensManager.getApiKey() else {
            return
        }
        
        let request = DictionaryRequest(
            word,
            apiKey,
            validationManager.areEnglishCharacters(word)
        )
        
        networkManager.perform(request) { (result: Result<DictionaryResponseModel, NetworkManagerError>) in
            switch result {
            case .success(let model):
                if model.body.isEmpty {
                    return
                }
                
                let word = Word(
                    word: model.body.first?.text ?? "",
                    detailTranslations: model.body.flatMap { wordModel in
                        wordModel.translations.map {
                            Translation(
                                id: -1,
                                translation: $0.text,
                                speechPart: $0.pos,
                                transcription: wordModel.transcription,
                                examples: $0.examples?.map { example in
                                    Example(
                                        id: -1,
                                        example: example.text,
                                        translation: example.translations.first?.text)
                                } ?? []
                            )
                        }
                    }
                )
                completion([word])
            case .failure(let error):
                print(error)
            }
        }
    }
}

private struct DictionaryResponseModel: Decodable {
    let body: [WordResponseModel]
    
    enum CodingKeys: String, CodingKey {
        case body = "def"
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
