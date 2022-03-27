//
//  Find_and_LearnTests.swift
//  Find-and-LearnTests
//
//  Created by Роман Сницарюк on 26.03.2022.
//

import XCTest
@testable import Find_and_Learn

final class UnitRegistrationTests: XCTestCase {
    // MARK: Properties
    
    private var registrationService: RegistrationAuthSerivce?
    
    // MARK: Setup
    
    override func setUpWithError() throws {
        registrationService = RegistrationService()
    }

    override func tearDownWithError() throws {
        registrationService = nil
    }

    // MARK: - Tests
    
    func testEmailCorrectValidate() {
        // Given
        let exceptedResult = true
        let email = "some@some.ru"
        let correctPassword = "000000000"
        let correctNick = "Sixzr"
        
        // When
        let test = registrationService?.registerUser(
            email: email,
            password: correctPassword,
            confirmPassword: correctPassword,
            nick: correctNick
        ).0
        
        // Then
        XCTAssertEqual(exceptedResult, test)
    }
    
    func testEmailUncorrectValidate() {
        // Given
        
        let exceptedResult = false
        let email = "notEmail"
        let correctPassword = "000000000"
        let correctNick = "Sixzr"
        
        // When
        
        let test = registrationService?.registerUser(
            email: email,
            password: correctPassword,
            confirmPassword: correctPassword,
            nick: correctNick
        ).0
        
        // Then
        
        XCTAssertEqual(exceptedResult, test)
    }
    
    func testPasswordsEqualUncorrectValidate() {
        // Given
        
        let exceptedResult = false
        let email = "some@some.ru"
        let correctPassword = "000000000"
        let uncorrectPassword = "1"
        let correctNick = "Sixzr"
        
        // When
        
        let test = registrationService?.registerUser(
            email: email,
            password: correctPassword,
            confirmPassword: uncorrectPassword,
            nick: correctNick
        ).0
        
        // Then
        
        XCTAssertEqual(exceptedResult, test)
    }
}
