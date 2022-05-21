//
//  TokensRepositoryProtocol.swift
//  Find-and-Learn
//
//  Created by Руслан on 20.05.2022.
//

import Foundation

protocol TokensManagerProtocol: AnyObject {
    func saveToken(_ token: String)
    func getToken() -> String?
    func removeToken()
    func getApiKey() -> String?
}
