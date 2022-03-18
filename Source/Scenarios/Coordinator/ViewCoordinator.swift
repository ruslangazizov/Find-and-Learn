//
//  ViewCoordinator.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.03.2022.
//

import Foundation
import UIKit

open class ViewCoordinator<RouteType, ParrentRoute>: Coordinator {
    var navigationController: UINavigationController?
    var parrentCoordinator: ModuleCoordinator<ParrentRoute>?
    
    func start(route: RouteType) {
    }
}
