//
//  WordDetailRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import Foundation
import UIKit

protocol WordDetailRouterProtocol: RouterProtocol {
    func showNewFlashcard(_ flashcardModel: FlashcardModel)
}

final class WordDetailRouter: WordDetailRouterProtocol {
    weak var view: UIViewController?
    
    func showNewFlashcard(_ flashcardModel: FlashcardModel) {
        let newFlashcardViewController = NewFlashcardAssembly.assemble(with: flashcardModel)
        view?.navigationController?.pushViewController(newFlashcardViewController, animated: true)
    }
}
