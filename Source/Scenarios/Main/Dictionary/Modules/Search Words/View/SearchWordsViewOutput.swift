//
//  SearchWordsViewOutput.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.03.2022.
//

import Foundation

protocol SearchWordsViewOutput: AnyObject {
    func didEnterWord(_ word: String?)
    func didTapFavoriteWordsBarButtonItem()
    func didTapHistoryWordsBarButtonItem()
    func didSelectWord(_ word: Word)
}
