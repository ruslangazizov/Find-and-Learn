//
//  HistoryWordsAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 01.04.2022.
//

import Foundation
import UIKit

final class HistoryWordsAssembly: AssemblyProtocol {
    static func assemble() -> UIViewController {
        let router = HistoryWordsRouter()
        let interactor = HistoryWordsInteractor(dataManager: DataManagerMock())
        let presenter = HistoryWordsPresenter(interactor: interactor, router: router)
        let view = HistoryWordsViewController(output: presenter)
        
        presenter.view = view
        router.view = view
        
        interactor.output = presenter
        
        return view
    }
}
