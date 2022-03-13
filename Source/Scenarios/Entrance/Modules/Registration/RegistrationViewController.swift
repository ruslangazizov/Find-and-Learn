//
//  ViewController.swift
//  Find-and-Learn
//
//  Created by Руслан on 24.02.2022.
//

import UIKit

final class RegistrationViewController: UIViewController {
    // MARK: - Dependencies
    var output: RegistrationViewOutput?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - ViewInput
extension RegistrationViewController: RegistrationViewInput {
}
