//
//  SearchWordsPresenter.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import Foundation

class SearchWordsPresenter {
    // MARK: Dependencies
    
    weak var view: SearchWordsViewInput?
    let router: DictionaryRouterInput
    let interactor: SearchWordsInteractorProtocol
    
    // MARK: Initializer
    
    init(router: DictionaryRouterInput, interactor: SearchWordsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - SearchWordsViewOutput

extension SearchWordsPresenter: SearchWordsViewOutput {
    func didEnterWord(_ word: String?) {
        interactor.getWords(word) { [weak self] wordModels in
            self?.view?.showWords(wordModels)
        }
    }
    
    func didTapFavoriteWordsBarButtonItem() {
        router.showFavoriteWords()
    }
    
    func didTapHistoryWordsBarButtonItem() {
        router.showHistoryWords()
    }
    
    func didSelectWord(_ word: Word) {
        router.showWordDetail(word)
    }
}
