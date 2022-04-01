//
//  SearchWordsAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 31.03.2022.
//

import Foundation
import UIKit

final class SearchWordsAssembly: AssemblyProtocol {
    private let router: DictionaryRouterProtocol
    
    init(router: DictionaryRouterProtocol) {
        self.router = router
    }
    
    func assemble() -> UIViewController {
        let interactor = SearchWordsInteractor(dataManager: DataManagerMock())
        let presenter = SearchWordsPresenter(router: router, interactor: interactor)
        let view = SearchWordsViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
