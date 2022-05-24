//
//  SearchWordsRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import Foundation
import UIKit
import Swinject

protocol SearchWordsRouterProtocol: RouterProtocol {
    func showFavoriteWords()
    func showHistoryWords()
    func showWordDetail(_ word: WordModel)
}

final class SearchWordsRouter: SearchWordsRouterProtocol {
    weak var view: UIViewController?
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func showFavoriteWords() {
        let favoriteWordsViewController = FavoriteWordsAssembly.assemble(using: container)
        view?.navigationController?.pushViewController(favoriteWordsViewController, animated: true)
    }
    
    func showHistoryWords() {
        let historyWordsViewController = HistoryWordsAssembly.assemble(using: container)
        view?.navigationController?.pushViewController(historyWordsViewController, animated: true)
    }
    
    func showWordDetail(_ word: WordModel) {
        let wordDetailViewController = WordDetailAssembly.assemble(with: word, using: container)
        view?.navigationController?.pushViewController(wordDetailViewController, animated: true)
    }
}
