//
//  HistoryWordsInteractorOutput.swift
//  Find-and-Learn
//
//  Created by Руслан on 01.04.2022.
//

import Foundation

protocol HistoryWordsInteractorOutput: AnyObject {
    func didFetchHistoryWords(_ historyWords: [HistoryWord])
}
