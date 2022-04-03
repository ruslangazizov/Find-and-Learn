//
//  HistoryWordsTableViewCell.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.04.2022.
//

import UIKit

class HistoryWordsTableViewCell: UITableViewCell {
    // MARK: UI
    
    private lazy var wordLabel: UILabel = {
        return UILabel()
    }()
    
    private lazy var translationsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var searchesCountLabel: UILabel = {
        return UILabel()
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = .labelsSpacing
        return stackView
    }()
    
    // MARK: Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        wordLabel.text = nil
        translationsLabel.text = nil
        searchesCountLabel.text = nil
    }
    
    // MARK: Configuration
    
    func addWord(_ word: String) -> Self {
        wordLabel.text = word
        return self
    }
    
    func addTranslations(_ translations: String) -> Self {
        translationsLabel.text = translations
        return self
    }
    
    func addSearchesCount(_ searchesCount: Int) -> Self {
        searchesCountLabel.text = String(searchesCount)
        return self
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
