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
        return UINavigationController(rootViewController: searchWordsViewController)
    }
}
