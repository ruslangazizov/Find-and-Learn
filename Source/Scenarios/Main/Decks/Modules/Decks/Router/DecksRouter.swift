//
//  DecksRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import UIKit
import Swinject

protocol DecksRouterProtocol: RouterProtocol {
    func showDeckDetail(_ deck: Deck)
}

final class DecksRouter: DecksRouterProtocol {
    weak var view: UIViewController?
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    func showDeckDetail(_ deck: Deck) {
        let viewController = DeckDetailAssembly.assemble(with: deck, using: container)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
}
