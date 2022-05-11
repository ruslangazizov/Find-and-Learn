//
//  SearchWordsAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 31.03.2022.
//

import Foundation
import UIKit

final class SearchWordsAssembly: AssemblyProtocol {
    static func assemble() -> UIViewController {
        let router = SearchWordsRouter()
        let interactor = SearchWordsInteractor(
            dataManager: DataManagerMock.shared,
            networkManager: NetworkManager(),
            validationManager: ValidationManager()
        )
        let presenter = SearchWordsPresenter(router: router, interactor: interactor)
        let view = SearchWordsViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
