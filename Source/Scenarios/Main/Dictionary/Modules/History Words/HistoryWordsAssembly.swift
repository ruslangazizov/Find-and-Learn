//
//  HistoryWordsAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.04.2022.
//

import Foundation
import UIKit
import Swinject

enum HistoryWordsAssembly {
    static func assemble(using container: Container) -> UIViewController {
        return container.resolveAsViewController(HistoryWordsViewInput.self)
    }
}
