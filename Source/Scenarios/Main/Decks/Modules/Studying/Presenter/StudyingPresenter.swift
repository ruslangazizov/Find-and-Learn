//
//  StudyingPresenter.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 23.04.2022.
//

import Foundation

protocol StudyingViewOutput: AnyObject {
}

final class StudyingPresenter: StudyingViewOutput {
    // MARK: Dependencies
    
    weak var view: StudyingViewInput?
    
    // MARK: Init
    
    init() {
    }
    
    // MARK: StudyingViewOutput
}
