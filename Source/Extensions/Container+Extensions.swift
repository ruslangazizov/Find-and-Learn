//
//  Container+Extensions.swift
//  Find-and-Learn
//
//  Created by Руслан on 24.05.2022.
//

import Swinject

extension Container {
    func resolveAsViewController<Service>(_ serviceType: Service.Type) -> UIViewController {
        guard let viewController = resolve(serviceType) as? UIViewController else {
            fatalError("Unable to cast \(serviceType.self)'s conforming class instance to UIViewController")
        }
        return viewController
    }
}
