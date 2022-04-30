//
//  AchievementTableViewCell.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 29.04.2022.
//

import UIKit

final class AchievementTableViewCell: UITableViewCell {
    // MARK: UI
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateOfGettingLabel: UILabel = {
        let label = UILabel()
        label.setFontSize(.secondaryTextFontSize)
        return label
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    
    func configure(with achievement: Achievement) {
        nameLabel.text = achievement.name
        iconImageView.image = achievement.image
        descriptionLabel.text = achievement.description
        if let date = achievement.dateOfGetting {
            dateOfGettingLabel.text = R.string.localizable.achievements_screen_date_of_getting_text() + date
        }
    }
    
    // MARK: Private
    
    private func configure() {
        iconImageView.contentMode = .scaleAspectFit
        isUserInteractionEnabled = false
    }
    
    private func setupLayout() {
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(CGFloat.smallInset)
            make.size.equalTo(CGFloat.imageSize)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(CGFloat.defaultInset)
            make.trailing.equalToSuperview().inset(CGFloat.smallInset)
            make.centerY.equalTo(iconImageView.snp.centerY)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(CGFloat.defaultInset)
            make.leading.trailing.equalToSuperview().inset(CGFloat.smallInset)
            make.bottom.equalToSuperview().inset(CGFloat.smallInset).priority(.low)
        }
        
        contentView.addSubview(dateOfGettingLabel)
        dateOfGettingLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(CGFloat.littleInset)
            make.trailing.equalToSuperview().inset(CGFloat.smallInset)
            make.bottom.equalToSuperview().inset(CGFloat.smallInset)
        }
    }
}

// MARK: - Constants

private extension CGFloat {
    static let imageSize: CGFloat = 40
    
    static let secondaryTextFontSize: CGFloat = 12
}
