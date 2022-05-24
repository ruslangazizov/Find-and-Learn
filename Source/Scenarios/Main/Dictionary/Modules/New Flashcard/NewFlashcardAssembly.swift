//
//  NewFlashcardAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 29.04.2022.
//

import Foundation
import UIKit
import Swinject

enum NewFlashcardAssembly {
    static func assemble(
        with newFlashcardModel: NewFlashcardModel?,
        deckId: Int? = nil,
        using container: Container
    ) -> UIViewController {
        let newFlashcardModel = newFlashcardModel ?? NewFlashcardModel()
        
        return container.resolveAsViewController(NewFlashcardViewInput.self, arguments: newFlashcardModel, deckId)
    }
}
