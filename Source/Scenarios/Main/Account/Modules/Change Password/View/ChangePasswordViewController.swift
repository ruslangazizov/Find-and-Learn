//
//  ChangePasswordViewController.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 18.04.2022.
//

import UIKit

final class ChangePasswordViewController: UIViewController {
    // MARK: UI
    
    // MARK: Dependencies
    
    private let presenter: ChangePasswordViewOutput
    
    // MARK: Init
    
    init(presenter: ChangePasswordViewOutput) {
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
