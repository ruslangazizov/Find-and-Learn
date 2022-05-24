//
//  DeckDetail.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import UIKit
import Swinject

enum DeckDetailAssembly {
    static func assemble(with model: Deck, using container: Container) -> UIViewController {
        return container.resolveAsViewController(DeckDetailViewInput.self, argument: model)
    }
}
