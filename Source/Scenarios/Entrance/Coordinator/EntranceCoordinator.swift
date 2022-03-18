//
//  EntranceCoordinator.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.03.2022.
//

import Foundation
import UIKit

final class EntranceCoordinator: Coordinator {
    // MARK: - Dependencies
    var navigationController: UINavigationController?
    
    // MARK: - Routing
    func start(route: EntranceRoute) {
    }
}

enum EntranceRoute: Route {
    case registration
}
