//
//  WordDetailViewController.swift
//  Find-and-Learn
//
//  Created by Руслан on 25.04.2022.
//

import UIKit

class WordDetailViewController: UIViewController {
    // MARK: Dependencies
    
    private let presenter: WordDetailViewOutput
    
    // MARK: Properties
    
    private var wordDetail: WordDetail?
    
    // MARK: Initializers
    
    init(presenter: WordDetailViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension WordDetailViewController: WordDetailViewInput {
    func showWord(_ wordDetail: WordDetail) {
        self.wordDetail = wordDetail
    }
}
