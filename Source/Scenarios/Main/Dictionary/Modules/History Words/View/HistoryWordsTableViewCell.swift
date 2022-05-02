//
//  HistoryWordsTableViewCell.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.04.2022.
//

import Foundation
import UIKit

final class HistoryWordsTableViewCell: UITableViewCell {
    // MARK: UI
    
    private lazy var wordLabel = UILabel()
    
    private lazy var translationsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var searchesCountLabel = UILabel()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = .labelsSpacing
        return stackView
    }()
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = R.color.defaultBackgroundColor()
        contentView.addSubview(labelsStackView)
        labelsStackView.addArrangedSubview(wordLabel)
        labelsStackView.addArrangedSubview(translationsLabel)
        labelsStackView.addArrangedSubview(searchesCountLabel)
        
        labelsStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.horizontalSidesInsets)
            make.top.bottom.equalToSuperview().inset(Constants.verticalSidesInsets)
        }
        translationsLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration
    
    func configure(with wordModel: HistoryWordModel) {
        wordLabel.text = wordModel.word
        translationsLabel.text = wordModel.translations
        searchesCountLabel.text = String(wordModel.searchesCount)
    }
}

// MARK: - Constants

private extension HistoryWordsTableViewCell {
    enum Constants {
        static let horizontalSidesInsets = 15
        static let verticalSidesInsets = 10
    }
}

private extension CGFloat {
    static let labelsSpacing: CGFloat = 8
}
