//
//  EntranceCoordinator.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.03.2022.
//

import Foundation
import UIKit

final class EntranceCoordinator: ViewCoordinator<EntranceRoute, AppRoute> {
    // MARK: - Routing
    override func start(route: EntranceRoute) {
    }
}

enum EntranceRoute: Route {
    case registration
}
