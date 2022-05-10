//
//  SearchWordsPresenter.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import Foundation

protocol SearchWordsViewOutput: AnyObject {
    func didEnterWord(_ word: String?)
    func didTapFavoriteWordsBarButtonItem()
    func didTapHistoryWordsBarButtonItem()
    func didSelectWord(_ word: WordModel)
}

final class SearchWordsPresenter: SearchWordsViewOutput {
    // MARK: Dependencies
    
    weak var view: SearchWordsViewInput?
    private let router: SearchWordsRouterProtocol
    private let interactor: SearchWordsInteractorProtocol
    
    // MARK: Initializer
    
    init(router: SearchWordsRouterProtocol, interactor: SearchWordsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: SearchWordsViewOutput
    
    func didEnterWord(_ word: String?) {
        interactor.getWords(word) { [weak self] words in
            let wordModels = words.map {
                WordModel(
                    word: $0.word,
                    translations: $0.translations.joined(separator: ", "),
                    detailTranslations: $0.detailTranslations
                )
            }
            self?.view?.showWords(wordModels)
        }
    }
    
    func didTapFavoriteWordsBarButtonItem() {
        router.showFavoriteWords()
    }
    
    func didTapHistoryWordsBarButtonItem() {
        router.showHistoryWords()
    }
    
    func didSelectWord(_ word: WordModel) {
        router.showWordDetail(word)
    }
}
