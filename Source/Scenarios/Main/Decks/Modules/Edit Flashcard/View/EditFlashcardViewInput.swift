//
//  EditFlashcardViewInput.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.05.2022.
//

import Foundation

protocol EditFlashcardViewInput: NewFlashcardViewInput {
    func changeNavigationBarTitle(_ newTitle: String)
    func deleteCreateReversedFlashcardOption()
    func changeDeckChoiceLabelText(_ newText: String)
}
