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
    
    private lazy var remembersCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.learnedColor()
        label.font = .boldSystemFont(ofSize: .standardFontSize)
        return label
    }()
    
    private lazy var forgetsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.studyMoreColor()
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
        remembersCountLabel.text = "\(model.remembersCount)"
        forgetsCountLabel.text = "\(model.forgetsCount)"
    }
    
    private func setupSubviews() {
        let statisticsStackView = UIStackView(arrangedSubviews: [remembersCountLabel, forgetsCountLabel])
        statisticsStackView.spacing = .smallInset
        
        contentView.addSubview(statisticsStackView)
        statisticsStackView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        contentView.addSubview(frontSideLabel)
        frontSideLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(CGFloat.shortInset)
            make.trailing.equalTo(statisticsStackView.snp.leading)
        }
        
        contentView.addSubview(backSideLabel)
        backSideLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(CGFloat.shortInset)
            make.leading.equalTo(statisticsStackView.snp.trailing)
        }
    }
}

// MARK: - Constants

private extension CGFloat {
    static let standardFontSize: CGFloat = 17
}
