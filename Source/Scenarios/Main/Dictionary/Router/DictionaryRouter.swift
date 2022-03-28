//
//  DictionaryRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import Foundation
import UIKit

final class DictionaryRouter: DictionaryRouterInput {
    weak var view: UINavigationController?
    
    func showFavoriteWords() {
        let mockFavoriteWordsViewController = UIViewController()
        mockFavoriteWordsViewController.view.backgroundColor = .green
        view?.pushViewController(mockFavoriteWordsViewController, animated: true)
    }
    
    func showHistoryWords() {
        let mockHistoryWordsViewController = UIViewController()
        mockHistoryWordsViewController.view.backgroundColor = .systemPink
        view?.pushViewController(mockHistoryWordsViewController, animated: true)
    }
    
    func showWordDetail(_ word: Word) {
        let mockWordDetailViewController = UIViewController()
        mockWordDetailViewController.view.backgroundColor = .cyan
        view?.pushViewController(mockWordDetailViewController, animated: true)
    }
}
