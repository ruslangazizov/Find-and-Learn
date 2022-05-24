//
//  AchievementsAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 29.04.2022.
//

import Foundation
import UIKit
import Swinject

enum AchievementsAssembly {
    static func assemble(using container: Container) -> UIViewController {
        return container.resolveAsViewController(AchievementsViewInput.self)
    }
}
