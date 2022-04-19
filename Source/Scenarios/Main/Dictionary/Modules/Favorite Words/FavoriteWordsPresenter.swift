//
//  FavoriteWordsPresenter.swift
//  Find-and-Learn
//
//  Created by Руслан on 07.04.2022.
//

import Foundation

protocol FavoriteWordsViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectWord(_ word: WordModel)
}

final class FavoriteWordsPresenter: FavoriteWordsViewOutput {
    // MARK: Dependencies
    
    weak var view: FavoriteWordsViewInput?
    private let router: FavoriteWordsRouterProtocol
    private let interactor: FavoriteWordsInteractorProtocol
    
    // MARK: Initializers
    
    init(router: FavoriteWordsRouterProtocol, interactor: FavoriteWordsInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: FavoriteWordsViewOutput
    
    func viewDidLoad() {
        interactor.fetchFavoriteWords { [weak self] words in
            let wordModels = words.map { word in
                WordModel(word: word.word, translations: word.translationsString)
            }
            self?.view?.showWords(wordModels)
        }
    }
    
    func didSelectWord(_ word: WordModel) {
        router.showWordDetail(word.word)
    }
}
