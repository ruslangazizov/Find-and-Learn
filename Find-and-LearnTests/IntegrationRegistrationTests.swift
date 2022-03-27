//
//  IntegrationRegistrationTests.swift
//  Find-and-LearnTests
//
//  Created by Роман Сницарюк on 27.03.2022.
//

import XCTest
@testable import Find_and_Learn

final class IntegrationRegistrationTests: XCTestCase {
    // MARK: Dependencies
    
    private var viewController: RegistrationViewController?
    private weak var presenter: RegistrationPresenter?
    
    // MARK: Setup
    
    override func setUpWithError() throws {
        viewController = RegistrationViewController()
        guard let viewController = viewController else { fatalError("VC didn't init") }

        let presenter = RegistrationPresenter(view: viewController)
        viewController.presenter = presenter
        self.presenter = presenter
    }

    override func tearDownWithError() throws {
        viewController = nil
        presenter = nil
    }

    // MARK: Tests
    
    func testModuleHasInitedCorrectly() {
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(viewController)
    }
    
    func testModuleHasNotLeakMemory() {
        viewController = nil
        
        XCTAssertNil(presenter)
    }
}
