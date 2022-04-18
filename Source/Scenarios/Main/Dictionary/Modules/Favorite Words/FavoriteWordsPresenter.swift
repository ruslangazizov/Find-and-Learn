//
//  FavoriteWordsPresenter.swift
//  Find-and-Learn
//
//  Created by Руслан on 07.04.2022.
//

import Foundation

final class FavoriteWordsPresenter {
    // MARK: Dependencies
    
    weak var view: FavoriteWordsViewInput?
    private let router: FavoriteWordsRouterProtocol
    private let interactor: FavoriteWordsInteractorProtocol
    
    // MARK: Initializers
    
    init(router: FavoriteWordsRouterProtocol, interactor: FavoriteWordsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - FavoriteWordsViewOutput

extension FavoriteWordsPresenter: FavoriteWordsViewOutput {
    func viewDidLoad() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.interactor.fetchFavoriteWords { [weak self] words in
                let wordModels = words.map { word in
                    WordModel(word: word.word, translations: word.translationsString)
                }
                DispatchQueue.main.async {
                    self?.view?.showWords(wordModels)
                }
            }
        }
    }
    
    func didSelectWord(_ word: WordModel) {
        router.showWordDetail(word.word)
    }
}
