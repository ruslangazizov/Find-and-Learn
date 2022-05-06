//
//  WordDetailRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import Foundation
import UIKit

protocol WordDetailRouterProtocol: RouterProtocol {
    func showNewFlashcard(_ model: NewFlashcardModel)
}

final class WordDetailRouter: WordDetailRouterProtocol {
    weak var view: UIViewController?
    
    func showNewFlashcard(_ model: NewFlashcardModel) {
        let newFlashcardViewController = NewFlashcardAssembly.assemble(with: model)
        view?.navigationController?.pushViewController(newFlashcardViewController, animated: true)
    }
}
