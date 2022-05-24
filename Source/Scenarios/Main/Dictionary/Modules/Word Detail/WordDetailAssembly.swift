//
//  WordDetailAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import Foundation
import UIKit
import Swinject

enum WordDetailAssembly {
    static func assemble(with model: WordModel, using container: Container) -> UIViewController {
        return container.resolveAsViewController(WordDetailViewInput.self, argument: model)
    }
}
