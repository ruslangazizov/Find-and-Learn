//
//  WordDetailPresenter.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import Foundation

protocol WordDetailViewOutput: AnyObject {
    func viewDidLoad()
    func didTapFavoriteWordButton()
    func didTapNewFlashcardButton(_ chosenTranslations: [TranslationModel])
}

final class WordDetailPresenter: WordDetailViewOutput {
    // MARK: Properties
    
    private let wordModel: WordModel
    private var wordDetail: WordDetail?
    
    // MARK: Dependencies
    
    weak var view: WordDetailViewInput?
    private let interactor: WordDetailInteractorProtocol
    private let router: WordDetailRouterProtocol
    
    // MARK: Initializer
    
    init(interactor: WordDetailInteractorProtocol, router: WordDetailRouterProtocol, wordModel: WordModel) {
        self.interactor = interactor
        self.router = router
        self.wordModel = wordModel
    }
    
    // MARK: WordDetailViewOutput
    
    func viewDidLoad() {
        interactor.getWordDetail(wordModel) { [weak self] wordDetail in
            self?.wordDetail = wordDetail
            let speechPartsModels = Dictionary(grouping: wordDetail.translations) { translation in
                translation.speechPart
            }.sorted { $0.key > $1.key }.map { speechPartString, translations in
                SpeechPartModel(
                    speechPart: speechPartString,
                    transcription: translations.first?.transcription,
                    translations: translations.map {
                        TranslationModel($0)
                    }
                )
            }
            let wordDetailModel = WordDetailModel(
                word: wordDetail.word,
                isFavorite: wordDetail.isFavorite,
                speechParts: speechPartsModels
            )
            self?.view?.showWord(wordDetailModel)
        }
    }
    
    func didTapFavoriteWordButton() {
        guard var isFavorite = wordDetail?.isFavorite,
            let wordId = wordDetail?.id else {
                return
            }
        isFavorite.toggle()
        wordDetail?.isFavorite = isFavorite
        view?.setIsFavoriteWord(isFavorite)
        interactor.changeWordStatus(wordId, isFavorite: isFavorite)
    }
    
    func didTapNewFlashcardButton(_ chosenTranslations: [TranslationModel]) {
        guard !chosenTranslations.isEmpty else {
            view?.showNoChosenTranslationsAlert()
            return
        }
        guard let wordDetail = wordDetail else { return }
        
        let translationsWithSynonyms = chosenTranslations.map { $0.translationWithSynonyms }
        let translationsExamples = chosenTranslations.flatMap { translationModel in
            translationModel.examples.map { exampleModel -> String in
                var text = exampleModel.example
                if let translation = exampleModel.translation {
                    text += " - " + translation
                }
                return text
            }
        }
        let newFlashcardModel = NewFlashcardModel(
            frontSide: wordDetail.word,
            backSide: translationsWithSynonyms.joined(separator: "\n"),
            deckIndex: nil,
            comment: translationsExamples.joined(separator: "\n")
        )
        router.showNewFlashcard(newFlashcardModel)
    }
}
