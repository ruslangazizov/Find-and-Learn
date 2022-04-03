//
//  HistoryWordsRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 02.04.2022.
//

import Foundation
import UIKit

final class HistoryWordsRouter: HistoryWordsRouterProtocol {
    weak var view: UIViewController?
    
    func showWordDetail(_ word: String) {
        // здесь будет просто WordDetailAssembly.assemble()
        let mockWordDetailViewController = UIViewController()
        mockWordDetailViewController.view.backgroundColor = .cyan
        mockWordDetailViewController.title = word
        view?.navigationController?.pushViewController(mockWordDetailViewController, animated: true)
    }
}
