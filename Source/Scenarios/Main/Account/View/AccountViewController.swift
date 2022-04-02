//
//  AccountViewController.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 02.04.2022.
//

import UIKit

final class AccountViewController: UIViewController {
    // MARK: UI
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: Dependencies
    
    private let presenter: AccountViewOutput
    
    // MARK: Init
    
    init(presenter: AccountViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Private
    
    private func setupLayout() {
    }
}

// MARK: - ViewInput

extension AccountViewController: AccountViewInput {
}
