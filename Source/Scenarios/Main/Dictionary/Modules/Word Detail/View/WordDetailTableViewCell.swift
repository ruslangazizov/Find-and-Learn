//
//  WordDetailTableViewCell.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import UIKit

final class WordDetailTableViewCell: UITableViewCell {
    // MARK: UI
    
    private lazy var checkboxButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = .borderWidth
        button.layer.borderColor = .buttonBorderColor
        button.layer.backgroundColor = .buttonBackgroundColorPassive
        button.addTarget(self, action: #selector(didTapCheckboxButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var translationLabel: UILabel = {
        let label = UILabel()
        label.setFontSize(.translationLabelFontSize)
        return label
    }()
    
    private lazy var examplesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .examplesStackViewSpacing
        return stackView
    }()
    
    private lazy var topSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separatorViewBackgroundColor
        return view
    }()
    
    private lazy var bottomSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separatorViewBackgroundColor
        return view
    }()
    
    // MARK: Properties
    
    var translationModel: TranslationModel?
    var bottomSeparatorViewIsHidden = false {
        didSet {
            bottomSeparatorView.isHidden = bottomSeparatorViewIsHidden
        }
    }
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .viewBackgroundColor
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI configuration
    
    private func configureSubviews() {
        addSubview(topSeparatorView)
        topSeparatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(Constants.separatorViewHeight)
        }
        
        addSubview(checkboxButton)
        checkboxButton.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.checkboxButtonSize)
            make.leading.equalToSuperview().inset(Constants.standardInset)
        }
        
        addSubview(translationLabel)
        translationLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkboxButton.snp.trailing).offset(Constants.standardInset)
            make.top.equalTo(topSeparatorView).inset(Constants.standardInset)
        }
        checkboxButton.snp.makeConstraints { make in
            make.centerY.equalTo(translationLabel)
        }
        
        addSubview(examplesStackView)
        examplesStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.standardInset * 2)
            make.top.equalTo(translationLabel.snp.bottom).offset(Constants.standardInset)
        }
        
        addSubview(bottomSeparatorView)
        bottomSeparatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(examplesStackView.snp.bottom).offset(Constants.standardInset)
            make.height.equalTo(Constants.separatorViewHeight)
        }
    }
    
    func configure(with translationModel: TranslationModel) {
        if self.translationModel == translationModel {
            return
        }
        self.translationModel = translationModel
        
        translationLabel.text = translationModel.translationWithSynonyms
        examplesStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        examplesStackView.addArrangedSubviews(translationModel.examples.map { exampleModel in
            var labelText = exampleModel.example
            if let translation = exampleModel.translation {
                labelText += " - " + translation
            }
            return TranslationExampleLabel(text: labelText)
        })
    }
    
    // MARK: Actions
    
    @objc private func didTapCheckboxButton(_ sender: UIButton) {
        translationModel?.isSelected.toggle()
        guard let isSelected = translationModel?.isSelected else { return }
        checkboxButton.layer.backgroundColor = isSelected ? .buttonBackgroundColorActive : .buttonBackgroundColorPassive
    }
}

// MARK: - Constants

private extension CGFloat {
    static let borderWidth: CGFloat = 2
    static let translationLabelFontSize: CGFloat = 18
    static let examplesStackViewSpacing: CGFloat = 4
}

private extension CGColor {
    static let buttonBorderColor: CGColor = UIColor.lightGray.cgColor
    static let buttonBackgroundColorActive: CGColor = UIColor.green.cgColor
    static let buttonBackgroundColorPassive: CGColor = UIColor.white.cgColor
}

private extension UIColor {
    static let viewBackgroundColor = UIColor(red: 250 / 255, green: 250 / 255, blue: 250 / 255, alpha: 1)
    static let separatorViewBackgroundColor = UIColor(red: 190 / 255, green: 190 / 255, blue: 190 / 255, alpha: 1)
}

private enum Constants {
    static let separatorViewHeight = 2
    static let checkboxButtonSize = 12
    static let standardInset = 8
}
