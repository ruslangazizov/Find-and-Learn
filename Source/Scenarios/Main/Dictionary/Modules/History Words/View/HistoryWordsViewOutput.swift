//
//  HistoryWordsViewOutput.swift
//  Find-and-Learn
//
//  Created by Руслан on 01.04.2022.
//

import Foundation

protocol HistoryWordsViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectWord(_ word: HistoryWordModel)
}
