//
//  NewFlashcardAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 29.04.2022.
//

import Foundation
import UIKit

final class NewFlashcardAssembly: TransitionAssemblyProtocol {
    typealias DataModel = FlashcardModel?
    
    static func assemble(with model: FlashcardModel?) -> UIViewController {
        let newFlashcardModel = NewFlashcardModel(model)
        
        let router = NewFlashcardRouter()
        let interactor = NewFlashcardInteractor(dataManager: DataManagerMock())
        let presenter = NewFlashcardPresenter(interactor: interactor, router: router)
        let view = NewFlashcardViewController(presenter: presenter, newFlashcardModel: newFlashcardModel)
        
        router.view = view
        presenter.view = view
        
        return view
    }
}
