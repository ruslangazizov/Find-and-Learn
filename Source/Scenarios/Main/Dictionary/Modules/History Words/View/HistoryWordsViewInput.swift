//
//  HistoryWordsViewInput.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.04.2022.
//

import Foundation

protocol HistoryWordsViewInput: AnyObject {
    func showWords(_ words: [HistoryWordsSection])
}
