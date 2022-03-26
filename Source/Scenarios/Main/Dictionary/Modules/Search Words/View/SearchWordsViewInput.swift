//
//  SearchWordsViewInput.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import Foundation

protocol SearchWordsViewInput: AnyObject {
    func showWords(_ words: [Word])
}
