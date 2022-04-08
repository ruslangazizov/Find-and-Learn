//
//  AccountAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import Foundation
import UIKit

final class AccountAssembly: AssemblyProtocol {
    static func assemble() -> UIViewController {
        let presenter = AccountPresenter()
        
        let viewController = AccountViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
