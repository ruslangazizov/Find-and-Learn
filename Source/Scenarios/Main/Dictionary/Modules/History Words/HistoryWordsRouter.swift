//
//  HistoryWordsRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.04.2022.
//

import Foundation
import UIKit

protocol HistoryWordsRouterProtocol: RouterProtocol {
    func showWordDetail(_ word: WordModel)
}

final class HistoryWordsRouter: HistoryWordsRouterProtocol {
    weak var view: UIViewController?
    
    func showWordDetail(_ word: WordModel) {
        let wordDetailViewController = WordDetailAssembly.assemble(with: word)
        view?.navigationController?.pushViewController(wordDetailViewController, animated: true)
    }
}
