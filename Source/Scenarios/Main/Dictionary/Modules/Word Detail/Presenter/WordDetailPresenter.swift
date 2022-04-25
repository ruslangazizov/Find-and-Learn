//
//  WordDetailPresenter.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import Foundation

protocol WordDetailViewOutput: AnyObject {
    func viewDidLoad()
}

final class WordDetailPresenter: WordDetailViewOutput {
    // MARK: Properties
    
    let wordModel: WordModel
    
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
        interactor.getWordDetail { [weak self] wordDetail in
            self?.view?.showWord(wordDetail)
        }
    }
}
