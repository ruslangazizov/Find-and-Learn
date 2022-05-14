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
        
        static let ruFlag = "ru"
        static let enFlag = "en"
    }
    
    let method: HTTP.Method = .get
    let path: String = "dicservice.json/lookup"
    let base: String = "https://dictionary.yandex.net/api/v1/"
    let queries: HTTP.Queries
    
    init(_ word: String, _ key: String, _ isFromEnglish: Bool) {
        queries = [
            "key": key,
            "lang": isFromEnglish ? Constants.fromEnToRu : Constants.fromRuToEn,
            "text": word,
            "ui": isFromEnglish ? Constants.ruFlag : Constants.enFlag
        ]
    }
}
