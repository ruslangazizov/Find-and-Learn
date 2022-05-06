//
//  EditFlashcardRouter.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.05.2022.
//

import UIKit

protocol EditFlashcardRouterProtocol: RouterProtocol {
    func pop()
}

final class EditFlashcardRouter: EditFlashcardRouterProtocol {
    weak var view: UIViewController?
    
    func pop() {
        view?.navigationController?.popViewController(animated: true)
    }
}
