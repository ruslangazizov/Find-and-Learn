//
//  WordDetailRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import Foundation
import UIKit
import Swinject

protocol WordDetailRouterProtocol: RouterProtocol {
    func showNewFlashcard(_ model: NewFlashcardModel)
}

final class WordDetailRouter: WordDetailRouterProtocol {
    weak var view: UIViewController?
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func showNewFlashcard(_ model: NewFlashcardModel) {
        let newFlashcardViewController = NewFlashcardAssembly.assemble(with: model, using: container)
        view?.navigationController?.pushViewController(newFlashcardViewController, animated: true)
    }
}
