//
//  DictionaryRouterInput.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import Foundation

protocol DictionaryRouterProtocol: RouterProtocol {
    func showFavoriteWords()
    func showHistoryWords()
    func showWordDetail(_ word: Word)
}
