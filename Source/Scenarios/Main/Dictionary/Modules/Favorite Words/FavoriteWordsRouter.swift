//
//  FavoriteWordsRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 07.04.2022.
//

import Foundation
import UIKit

protocol FavoriteWordsRouterProtocol: RouterProtocol {
    func showWordDetail(_ word: String)
}

final class FavoriteWordsRouter: FavoriteWordsRouterProtocol {
    weak var view: UIViewController?
    
    func showWordDetail(_ word: String) {
        // здесь будет просто WordDetailAssembly.assemble()
        let mockWordDetailViewController = UIViewController()
        mockWordDetailViewController.view.backgroundColor = .cyan
        mockWordDetailViewController.title = word
        view?.navigationController?.pushViewController(mockWordDetailViewController, animated: true)
    }
}
