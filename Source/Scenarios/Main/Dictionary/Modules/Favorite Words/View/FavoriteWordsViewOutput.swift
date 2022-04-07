//
//  FavoriteWordsViewOutput.swift
//  Find-and-Learn
//
//  Created by Руслан on 07.04.2022.
//

import Foundation

protocol FavoriteWordsViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectWord(_ word: WordModel)
}
