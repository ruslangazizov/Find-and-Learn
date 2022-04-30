//
//  NewFlashcardRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 29.04.2022.
//

import Foundation
import UIKit

protocol NewFlashcardRouterProtocol: RouterProtocol {
    func pop()
}

final class NewFlashcardRouter: NewFlashcardRouterProtocol {
    weak var view: UIViewController?
    
    func pop() {
        view?.navigationController?.popViewController(animated: true)
    }
}
