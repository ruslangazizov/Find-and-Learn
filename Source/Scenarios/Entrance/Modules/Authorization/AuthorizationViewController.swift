//
//  AuthorizationViewController.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 25.03.2022.
//

import UIKit

final class AuthorizationViewController: UIViewController {
    // MARK: Ui
    
    // MARK: Dependencies
    
    private var presenter: AuthorizationViewOutput
    
    // MARK: Init
    
    init(presenter: AuthorizationViewOutput) {
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
}

// MARK: - ViewInput

extension AuthorizationViewController: AuthorizationViewInput {
}
