//
//  WordDetailRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import Foundation
import UIKit

protocol WordDetailRouterProtocol: RouterProtocol {
}

final class WordDetailRouter: WordDetailRouterProtocol {
    weak var view: UIViewController?
}
