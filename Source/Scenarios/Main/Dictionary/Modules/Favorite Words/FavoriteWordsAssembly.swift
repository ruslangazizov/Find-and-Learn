//
//  FavoriteWordsAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 07.04.2022.
//

import Foundation
import UIKit

final class FavoriteWordsAssembly: AssemblyProtocol {
    static func assemble() -> UIViewController {
        let router = FavoriteWordsRouter()
        let interactor = FavoriteWordsInteractor(dataManager: DataManagerMock())
        let presenter = FavoriteWordsPresenter(router: router, interactor: interactor)
        let view = FavoriteWordsViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
