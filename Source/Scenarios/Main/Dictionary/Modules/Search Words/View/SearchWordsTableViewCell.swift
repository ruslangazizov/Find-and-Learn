//
//  SearchWordsTableViewCell.swift
//  Find-and-Learn
//
//  Created by Руслан on 28.03.2022.
//

import UIKit

class SearchWordsTableViewCell: UITableViewCell {
    static let reuseIdentifier = String(describing: SearchWordsTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with word: Word) {
        textLabel?.text = word.word
        detailTextLabel?.text = word.translationsString
    }
}
