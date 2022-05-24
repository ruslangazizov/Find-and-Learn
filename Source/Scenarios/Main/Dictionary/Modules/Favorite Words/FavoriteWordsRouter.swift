//
//  FavoriteWordsRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 07.04.2022.
//

import Foundation
import UIKit
import Swinject

protocol FavoriteWordsRouterProtocol: RouterProtocol {
    func showWordDetail(_ word: WordModel)
}

final class FavoriteWordsRouter: FavoriteWordsRouterProtocol {
    weak var view: UIViewController?
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func showWordDetail(_ word: WordModel) {
        let wordDetailViewController = WordDetailAssembly.assemble(with: word, using: container)
        view?.navigationController?.pushViewController(wordDetailViewController, animated: true)
    }
}
