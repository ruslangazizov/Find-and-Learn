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
    
    func resolveAsViewController<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> UIViewController {
        guard let viewController = resolve(serviceType, argument: argument) as? UIViewController else {
            fatalError("Unable to cast \(serviceType.self)'s conforming class instance to UIViewController")
        }
        return viewController
    }
    
    func resolveAsViewController<Service, Arg1, Arg2>(
        _ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2
    ) -> UIViewController {
        guard let viewController = resolve(serviceType, arguments: arg1, arg2) as? UIViewController else {
            fatalError("Unable to cast \(serviceType.self)'s conforming class instance to UIViewController")
        }
        return viewController
    }
    
    func resolveAsViewController<Service, Arg1, Arg2, Arg3>(
        _ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3
    ) -> UIViewController {
        guard let viewController = resolve(serviceType, arguments: arg1, arg2, arg3) as? UIViewController else {
            fatalError("Unable to cast \(serviceType.self)'s conforming class instance to UIViewController")
        }
        return viewController
    }
}
