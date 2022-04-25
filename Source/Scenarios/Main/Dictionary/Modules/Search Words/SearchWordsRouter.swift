//
//  SearchWordsRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import Foundation
import UIKit

protocol SearchWordsRouterProtocol: RouterProtocol {
    func showFavoriteWords()
    func showHistoryWords()
    func showWordDetail(_ word: WordModel)
}

final class SearchWordsRouter: SearchWordsRouterProtocol {
    weak var view: UIViewController?
    
    func showFavoriteWords() {
        let favoriteWordsViewController = FavoriteWordsAssembly.assemble()
        view?.navigationController?.pushViewController(favoriteWordsViewController, animated: true)
    }
    
    func showHistoryWords() {
        let historyWordsViewController = HistoryWordsAssembly.assemble()
        view?.navigationController?.pushViewController(historyWordsViewController, animated: true)
    }
    
    func showWordDetail(_ word: WordModel) {
        let wordDetailViewController = WordDetailAssembly.assemble(with: word)
        view?.navigationController?.pushViewController(wordDetailViewController, animated: true)
    }
}
