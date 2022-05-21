//
//  DecksAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import UIKit

final class DecksAssembly: AssemblyProtocol {
    static func assemble() -> UIViewController {
        let interactor = DecksInteractor(
            decksRepository: DecksRepository(coreDataManager: CoreDataManager.shared),
            stringFormatter: StringFormatter()
        )
        let router = DecksRouter()
        
        let presenter = DecksPresenter(interactor: interactor, router: router)
        let view = DecksViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
