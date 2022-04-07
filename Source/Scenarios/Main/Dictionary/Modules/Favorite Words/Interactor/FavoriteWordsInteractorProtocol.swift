//
//  FavoriteWordsInteractorProtocol.swift
//  Find-and-Learn
//
//  Created by Руслан on 07.04.2022.
//

import Foundation

protocol FavoriteWordsInteractorProtocol: AnyObject {
    func fetchFavoriteWords(completion: @escaping ([Word]) -> Void)
}
