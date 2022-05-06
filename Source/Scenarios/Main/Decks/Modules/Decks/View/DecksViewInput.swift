//
//  DecksViewInput.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.05.2022.
//

import Foundation

protocol DecksViewInput: AnyObject {
    func showDecks(_ models: [DeckModel])
    func appendDeck(_ model: DeckModel)
    func setAlertActionIsEnabled(_ isEnabled: Bool)
}
