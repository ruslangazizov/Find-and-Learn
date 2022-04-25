//
//  WordDetailAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import Foundation
import UIKit

final class WordDetailAssembly: AssemblyProtocol {
    static func assemble() -> UIViewController {
        let router = WordDetailRouter()
        let interactor = WordDetailInteractor(dataManager: DataManagerMock())
        let presenter = WordDetailPresenter(interactor: interactor, router: router)
        let view = WordDetailViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
