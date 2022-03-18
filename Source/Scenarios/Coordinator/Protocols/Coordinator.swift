//
//  Coordinator.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 14.03.2022.
//

import UIKit

protocol Coordinator {
    associatedtype RouteType
    
    var navigationController: UINavigationController? { get set }
    
    func start(route: RouteType)
}
