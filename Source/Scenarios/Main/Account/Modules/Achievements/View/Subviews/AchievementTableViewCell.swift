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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
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
        titleLabel.text = achievement.name
        iconImageView.image = achievement.image
    }
    
    // MARK: Private
    
    private func configure() {
        iconImageView.contentMode = .scaleAspectFit
    }
    
    private func setupLayout() {
    }
}
