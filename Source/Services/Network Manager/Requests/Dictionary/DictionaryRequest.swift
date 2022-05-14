//
//  DictionaryRequest.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 09.05.2022.
//

import Foundation

struct DictionaryRequest: Request {
    private enum Constants {
        static let fromEnToRu = "en-ru"
        static let fromRuToEn = "ru-en"
    }
    
    private(set) var method: HTTP.Method = .get
    private(set) var path: String = "dicservice.json/lookup"
    private(set) var base: String = "https://dictionary.yandex.net/api/v1/"
    private(set) var queries: HTTP.Queries
    
    init(_ word: String, _ key: String, _ isFromEnglish: Bool) {
        queries = [
            "key": key,
            "lang": isFromEnglish ? Constants.fromEnToRu : Constants.fromRuToEn,
            "text": word
        ]
    }
}
