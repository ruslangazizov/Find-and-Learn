//
//  AccountInteractorProtocol.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 08.04.2022.
//

import Foundation

protocol AccountInteractorProtocol: AnyObject {
    func loadSettings(_ completion: (([Setting], String) -> Void))
}
