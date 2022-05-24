//
//  ChangePasswordAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.04.2022.
//

import Foundation
import UIKit
import Swinject

enum ChangePasswordAssembly {
    static func assemble(using container: Container) -> UIViewController {
        return container.resolveAsViewController(ChangePasswordViewInput.self)
    }
}
