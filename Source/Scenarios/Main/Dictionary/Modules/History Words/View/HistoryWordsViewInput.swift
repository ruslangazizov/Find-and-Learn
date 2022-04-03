//
//  HistoryWordsViewInput.swift
//  Find-and-Learn
//
//  Created by Руслан on 01.04.2022.
//

import Foundation

protocol HistoryWordsViewInput: AnyObject {
    func showWords(_ words: [HistoryWordsSection])
}
