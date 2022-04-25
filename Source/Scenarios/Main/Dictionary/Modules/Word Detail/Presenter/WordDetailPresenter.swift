//
//  WordDetailPresenter.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import Foundation

protocol WordDetailViewOutput: AnyObject {
}

final class WordDetailPresenter: WordDetailViewOutput {
    // MARK: Properties
    
    let word: WordModel
    
    // MARK: Dependencies
    
    weak var view: WordDetailViewInput?
    private let interactor: WordDetailInteractorProtocol
    private let router: WordDetailRouterProtocol
    
    // MARK: Initializer
    
    init(interactor: WordDetailInteractorProtocol, router: WordDetailRouterProtocol, word: WordModel) {
        self.interactor = interactor
        self.router = router
        self.word = word
    }
}
