//
//  EntranceAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 06.04.2022.
//

import Foundation
import UIKit
import Swinject

enum EntranceAssembly {
    static func assemble(using container: Container) -> UIViewController {
        let startViewController = UINavigationController(
            rootViewController: AuthorizationAssembly.assemble(using: container)
        )
        startViewController.isNavigationBarHidden = true
        return startViewController
    }
}
