//
//  DataManagerMock.swift
//  Find-and-Learn
//
//  Created by Руслан on 31.03.2022.
//

import Foundation

final class DataManagerMock: DataManagerProtocol {
    func getWords(_ word: String, completion: @escaping ([Word]) -> Void) {
        completion([
            Word(word: "Слово1", translations: ["Перевод1", "Перевод2", "Перевод7", "Перевод8"]),
            Word(word: "Слово2", translations: ["Перевод3", "Перевод4"]),
            Word(word: "Слово3", translations: ["Перевод5", "Перевод6"])
        ])
    }
}
