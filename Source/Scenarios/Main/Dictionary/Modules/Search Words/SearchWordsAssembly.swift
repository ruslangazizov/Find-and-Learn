//
//  SearchWordsAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 31.03.2022.
//

import Foundation
import UIKit
import Swinject

enum SearchWordsAssembly {
    static func assemble(using container: Container) -> UIViewController {
        return container.resolveAsViewController(SearchWordsViewInput.self)
    }
}
