//
//  FavoriteWordsRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 07.04.2022.
//

import Foundation
import UIKit

protocol FavoriteWordsRouterProtocol: RouterProtocol {
    func showWordDetail(_ word: WordModel)
}

final class FavoriteWordsRouter: FavoriteWordsRouterProtocol {
    weak var view: UIViewController?
    
    func showWordDetail(_ word: WordModel) {
        let wordDetailViewController = WordDetailAssembly.assemble(with: word)
        view?.navigationController?.pushViewController(wordDetailViewController, animated: true)
    }
}
