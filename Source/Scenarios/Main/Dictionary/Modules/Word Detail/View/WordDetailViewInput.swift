//
//  WordDetailViewInput.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import Foundation

protocol WordDetailViewInput: AnyObject {
    func showWord(_ wordDetail: WordDetailModel)
    func setIsFavoriteWord(_ isFavorite: Bool)
    func showNoChosenTranslationsAlert()
}
