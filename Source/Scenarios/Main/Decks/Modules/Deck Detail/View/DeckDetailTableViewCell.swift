//
//  DeckDetailTableViewCell.swift
//  Find-and-Learn
//
//  Created by Руслан on 04.05.2022.
//

import UIKit

final class DeckDetailTableViewCell: UITableViewCell {
    // MARK: UI
    
    private lazy var frontSideLabel = UILabel()
    
    private lazy var statisticsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: .standardFontSize)
        return label
    }()
    
    private lazy var backSideLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = R.color.defaultBackgroundColor()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration
    
    func configure(with model: Flashcard) {
        frontSideLabel.text = model.frontSide
        backSideLabel.text = model.backSide
        
        let remembersString = "\(model.remembersCount)  ".applyingColor(R.color.learnedColor() ?? .green)
        let forgetsString = "\(model.forgetsCount)".applyingColor(R.color.studyMoreColor() ?? .orange)
        statisticsLabel.attributedText = remembersString.appending(forgetsString)
    }
    
    private func setupSubviews() {
        contentView.addSubview(statisticsLabel)
        statisticsLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        contentView.addSubview(frontSideLabel)
        frontSideLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(CGFloat.shortInset)
            make.trailing.equalTo(statisticsLabel.snp.leading)
        }
        
        contentView.addSubview(backSideLabel)
        backSideLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(CGFloat.shortInset)
            make.leading.equalTo(statisticsLabel.snp.trailing)
        }
    }
}

// MARK: Constants

private extension CGFloat {
    static let standardFontSize: CGFloat = 17
}
