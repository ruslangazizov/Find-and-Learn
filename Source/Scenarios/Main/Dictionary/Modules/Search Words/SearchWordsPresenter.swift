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
    private var searchTask: DispatchWorkItem?
    
    // MARK: Initializer
    
    init(router: SearchWordsRouterProtocol, interactor: SearchWordsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: SearchWordsViewOutput
    
    func didEnterWord(_ word: String?) {
        searchTask?.cancel()
        
        let task = DispatchWorkItem { [weak self] in
            self?.interactor.getWords(word) { [weak self] words in
                let wordModels = words.map {
                    WordModel(
                        word: $0.word,
                        translations: $0.detailTranslations?.compactMap {
                            $0.translation
                        }
                        .joined(separator: ", ") ?? "",
                        detailTranslations: $0.detailTranslations
                    )
                }
                self?.view?.showWords(wordModels)
            }
        }
        searchTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: task)
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
