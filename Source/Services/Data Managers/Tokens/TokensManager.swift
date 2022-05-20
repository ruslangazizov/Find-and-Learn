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
        KeyChainManager.save(key: backendTokenKeyChainKey, data: Data(from: token))
    }
    
    func getToken() -> String? {
        return KeyChainManager.load(key: backendTokenKeyChainKey)?.to(type: String.self)
    }
    
    func removeToken() {
        KeyChainManager.remove(key: backendTokenKeyChainKey)
    }
    
    func getApiKey() -> String? {
        return "dict.1.1.20220509T162427Z.6fc4e65140e1e3dc.6be551b61e08e1351dce814bb39a1f6e6fb58573"
    }
}
