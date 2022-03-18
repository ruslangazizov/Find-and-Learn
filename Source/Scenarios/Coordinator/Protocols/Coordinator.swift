//
//  Coordinator.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 14.03.2022.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    var rootCoordinator: Coordinator? { get set }
    
    func start()
}
