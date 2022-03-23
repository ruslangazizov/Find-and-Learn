//
//  PasswordRecoveryViewController.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.03.2022.
//

import UIKit

final class PasswordRecoveryViewController: UIViewController {
    // MARK: Dependencies
    
    private var output: PasswordRecoveryViewOutput
    
    // MARK: Init
    
    init(output: PasswordRecoveryViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

// MARK: - ViewInput

extension PasswordRecoveryViewController: PasswordRecoveryViewInput {
}
