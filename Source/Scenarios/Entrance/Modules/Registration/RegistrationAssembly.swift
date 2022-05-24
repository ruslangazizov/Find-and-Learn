//
//  RegistrationAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 05.04.2022.
//

import Foundation
import UIKit
import Swinject

enum RegistrationAssembly {
    static func assemble(using container: Container) -> UIViewController {
        return container.resolveAsViewController(RegistrationViewInput.self)
    }
}
