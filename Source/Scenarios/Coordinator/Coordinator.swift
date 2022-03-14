//
//  Coordinator.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 14.03.2022.
//

import UIKit

protocol Coordinator {
    var rootViewController: UINavigationController? { get set }
    
    func start(window: UIWindow?)
    
    func perfomTransition(with type: Transitions)
}
