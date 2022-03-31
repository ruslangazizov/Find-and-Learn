//
//  DictionaryAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 31.03.2022.
//

import Foundation
import UIKit

final class DictionaryAssembly: AssemblyProtocol {
    func assemble() -> UIViewController {
        let router = DictionaryRouter()
        let searchWordsViewController = SearchWordsAssembly(router: router).assemble()
        return UINavigationController(rootViewController: searchWordsViewController)
    }
}
