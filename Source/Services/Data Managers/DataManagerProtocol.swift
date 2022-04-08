//
//  DataManagerProtocol.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import Foundation

protocol DataManagerProtocol: AnyObject {
    func getWords(_ word: String, completion: @escaping ([Word]) -> Void)
    func getUser(completion: ((User) -> Void))
    func fetchHistoryWords(completion: @escaping ([HistoryWord]) -> Void)
    func fetchFavoriteWords(completion: @escaping ([Word]) -> Void)
}
