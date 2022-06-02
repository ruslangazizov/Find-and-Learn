//
//  ConfirmEmailAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 02.06.2022.
//

import UIKit
import Swinject

enum ConfirmEmailAssembly {
    static func assemble(using container: Container) -> UIViewController {
        return container.resolveAsViewController(ConfirmEmailViewInput.self)
    }
}
