//
//  DeckDetailTableViewCell.swift
//  Find-and-Learn
//
//  Created by Руслан on 04.05.2022.
//

import UIKit

final class DeckDetailTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.defaultBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Flashcard) {
        textLabel?.text = model.frontSide
        detailTextLabel?.text = model.backSide
    }
}
