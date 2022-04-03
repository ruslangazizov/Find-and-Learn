//
//  SearchWordsRouterProtocol.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import Foundation

protocol SearchWordsRouterProtocol: RouterProtocol {
    func showFavoriteWords()
    func showHistoryWords()
    func showWordDetail(_ word: Word)
}
