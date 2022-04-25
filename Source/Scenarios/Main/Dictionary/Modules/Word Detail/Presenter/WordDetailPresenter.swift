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
    weak var view: WordDetailViewInput?
    private let interactor: WordDetailInteractorProtocol
    private let router: WordDetailRouterProtocol
    
    init(interactor: WordDetailInteractorProtocol, router: WordDetailRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
