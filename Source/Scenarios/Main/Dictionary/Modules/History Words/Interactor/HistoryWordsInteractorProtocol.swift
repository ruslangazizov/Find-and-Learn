//
//  HistoryWordsInteractorProtocol.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.04.2022.
//

import Foundation

protocol HistoryWordsInteractorProtocol: AnyObject {
    func fetchHistoryWords(completion: @escaping ([HistoryWord]) -> Void)
}
