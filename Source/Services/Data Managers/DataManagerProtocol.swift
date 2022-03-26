//
//  DataManagerProtocol.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import Foundation

protocol DataManagerProtocol: AnyObject {
    func getWords(_ word: String, completion: @escaping ([Word]) -> Void)
}
