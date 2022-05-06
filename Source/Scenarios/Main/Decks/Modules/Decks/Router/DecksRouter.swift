//
//  DecksRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import UIKit

protocol DecksRouterProtocol: RouterProtocol {
    func showDeckDetail(_ deck: Deck)
}

final class DecksRouter: DecksRouterProtocol {
    weak var view: UIViewController?
    
    func showDeckDetail(_ deck: Deck) {
        let viewController = DeckDetailAssembly.assemble(with: deck)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
}
