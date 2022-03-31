//
//  SearchWordsAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 31.03.2022.
//

import Foundation
import UIKit

final class SearchWordsAssembly: ScreenAssemblyProtocol {
    static func assemble(with router: RouterProtocol) -> UIViewController {
        guard let router = router as? DictionaryRouterProtocol else {
            let routerType = type(of: router)
            fatalError("Wrong type (\(routerType.self)) was provided for router, expected DictionaryRouterProtocol")
        }
        
        let interactor = SearchWordsInteractor(dataManager: DataManagerMock())
        let presenter = SearchWordsPresenter(router: router, interactor: interactor)
        let view = SearchWordsViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
