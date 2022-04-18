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
    func didSelectWord(_ word: Word)
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
        interactor.getWords(word) { [weak self] wordModels in
            DispatchQueue.main.async {
                self?.view?.showWords(wordModels)
            }
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
