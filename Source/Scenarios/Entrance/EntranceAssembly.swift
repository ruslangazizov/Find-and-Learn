//
//  EntranceAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 06.04.2022.
//

import Foundation
import UIKit

final class EntranceAssembly: AssemblyProtocol {
    static func assemble() -> UIViewController {
        let startViewController = UINavigationController(rootViewController: AuthorizationAssembly.assemble())
        startViewController.isNavigationBarHidden = true
        return startViewController
    }
}
