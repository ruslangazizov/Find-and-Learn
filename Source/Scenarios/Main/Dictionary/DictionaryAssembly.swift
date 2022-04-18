//
//  DictionaryAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 31.03.2022.
//

import Foundation
import UIKit

final class DictionaryAssembly: AssemblyProtocol {
    static func assemble() -> UIViewController {
        let searchWordsViewController = SearchWordsAssembly.assemble()
        let navigationController = UINavigationController(rootViewController: searchWordsViewController)
        navigationController.view.backgroundColor = .systemBackground
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .systemBackground
        navigationController.navigationBar.standardAppearance = barAppearance
        navigationController.navigationBar.scrollEdgeAppearance = barAppearance
        
        return navigationController
    }
}
