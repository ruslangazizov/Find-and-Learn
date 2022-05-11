//
//  HistoryWordsAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.04.2022.
//

import Foundation
import UIKit

final class HistoryWordsAssembly: AssemblyProtocol {
    static func assemble() -> UIViewController {
        let router = HistoryWordsRouter()
        let interactor = HistoryWordsInteractor(dataManager: DataManagerMock.shared)
        let presenter = HistoryWordsPresenter(interactor: interactor, router: router)
        let view = HistoryWordsViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
