//
//  FavoriteWordsAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 07.04.2022.
//

import Foundation
import UIKit
import Swinject

enum FavoriteWordsAssembly {
    static func assemble(using container: Container) -> UIViewController {
        return container.resolveAsViewController(FavoriteWordsViewInput.self)
    }
}
