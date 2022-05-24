//
//  PasswordRecoveryAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 01.04.2022.
//

import Foundation
import UIKit
import Swinject

enum PasswordRecoveryAssembly {
    static func assemble(using container: Container) -> UIViewController {
        return container.resolveAsViewController(PasswordRecoveryViewInput.self)
    }
}
