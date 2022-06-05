//
//  TokensRepository.swift
//  Find-and-Learn
//
//  Created by Руслан on 20.05.2022.
//

import Foundation

final class TokensManager: TokensManagerProtocol {
    private let backendTokenKeyChainKey = "backendTokenKeyChainKey"
    
    func saveToken(_ token: String) {
        guard let data = token.data(using: .utf8) else {
            assertionFailure("Unable to convert token from String to Data type")
            return
        }
        KeyChainManager.save(key: backendTokenKeyChainKey, data: data)
    }
    
    func getToken() -> String? {
        if let data = KeyChainManager.load(key: backendTokenKeyChainKey) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func removeToken() {
        KeyChainManager.remove(key: backendTokenKeyChainKey)
    }

    // TODO: (r.akhmadeev) Выглядит немного архаично, будто на джаве писали) Можно заменить на get-only свойство
    func getApiKey() -> String? {
        return "dict.1.1.20220509T162427Z.6fc4e65140e1e3dc.6be551b61e08e1351dce814bb39a1f6e6fb58573"
    }
}
