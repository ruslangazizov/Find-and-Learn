//
//  DictionaryAssembly.swift
//  Find-and-Learn
//
//  Created by Руслан on 31.03.2022.
//

import Foundation
import UIKit

final class DictionaryAssembly: FlowAssemblyProtocol {
    static func assemble() -> UIViewController {
        let router = DictionaryRouter()
        return SearchWordsAssembly.assemble(with: router)
    }
}
