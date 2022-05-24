//
//  StudyingAssembly.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import Foundation
import UIKit
import Swinject

enum StudyingAssembly {
    static func assemble(with models: [Flashcard], using container: Container) -> UIViewController {
        return container.resolveAsViewController(StudyingViewInput.self, argument: models)
    }
}
