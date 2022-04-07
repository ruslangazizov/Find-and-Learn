//
//  FavoriteWordsViewInput.swift
//  Find-and-Learn
//
//  Created by Руслан on 07.04.2022.
//

import Foundation

protocol FavoriteWordsViewInput: AnyObject {
    func showWords(_ words: [WordModel])
}
