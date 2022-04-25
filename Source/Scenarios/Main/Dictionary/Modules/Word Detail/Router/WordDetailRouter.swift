//
//  WordDetailRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import Foundation
import UIKit

protocol WordDetailProtocol: RouterProtocol {
}

final class WordDetail: WordDetailProtocol {
    weak var view: UIViewController?
}
