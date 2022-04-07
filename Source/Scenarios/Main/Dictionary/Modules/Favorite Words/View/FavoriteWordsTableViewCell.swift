//
//  FavoriteWordsTableViewCell.swift
//  Find-and-Learn
//
//  Created by Руслан on 07.04.2022.
//

import UIKit

class FavoriteWordsTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with word: WordModel) {
        textLabel?.text = word.word
        detailTextLabel?.text = word.translations
    }
}
