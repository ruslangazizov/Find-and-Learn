//
//  StringFormatter.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import Foundation

protocol StringFormatterProtocol: AnyObject {
    func formatFlashcardsCount(_ count: Int) -> String
}

final class StringFormatter: StringFormatterProtocol {
    func formatFlashcardsCount(_ count: Int) -> String {
        let countString = "\(count) "
        // TODO: (r.akhmadeev) Можно заменить на (11 ... 14)
        if [11, 12, 13, 14].contains(count % 100) {
            return countString + "карточек"
        }
        switch count % 10 {
        case 1:
            return countString + "карточка"
        case 2...4:
            return countString + "карточки"
        default:
            return countString + "карточек"
        }
    }
}
