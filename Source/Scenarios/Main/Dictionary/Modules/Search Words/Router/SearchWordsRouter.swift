//
//  SearchWordsRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import Foundation
import UIKit

final class SearchWordsRouter: SearchWordsRouterProtocol {
    weak var view: UIViewController?
    
    func showFavoriteWords() {
        // здесь будет просто FavoriteWordsAssembly.assemble()
        let mockFavoriteWordsViewController = UIViewController()
        mockFavoriteWordsViewController.view.backgroundColor = .green
        view?.navigationController?.pushViewController(mockFavoriteWordsViewController, animated: true)
    }
    
    func showHistoryWords() {
        let historyWordsViewController = HistoryWordsAssembly.assemble()
        view?.navigationController?.pushViewController(historyWordsViewController, animated: true)
    }
    
    func showWordDetail(_ word: Word) {
        // здесь будет просто WordDetailAssembly.assemble()
        let mockWordDetailViewController = UIViewController()
        mockWordDetailViewController.view.backgroundColor = .cyan
        view?.navigationController?.pushViewController(mockWordDetailViewController, animated: true)
    }
}
