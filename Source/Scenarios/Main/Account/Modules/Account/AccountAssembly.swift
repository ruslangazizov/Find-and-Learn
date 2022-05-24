//
//  AccountAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import Foundation
import UIKit
import Swinject

enum AccountAssembly {
    static func assemble(using container: Container) -> UIViewController {
        return container.resolveAsViewController(AccountViewInput.self)
    }
}
