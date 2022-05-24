//
//  DecksAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import UIKit
import Swinject

enum DecksAssembly {
    static func assemble(using container: Container) -> UIViewController {
        return container.resolveAsViewController(DecksViewInput.self)
    }
}
