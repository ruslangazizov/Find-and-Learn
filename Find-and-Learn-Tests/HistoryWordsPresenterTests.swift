//
//  HistoryWordsPresenterTests.swift
//  Find-and-Learn-Tests
//
//  Created by Руслан on 03.04.2022.
//

import XCTest
@testable import Find_and_Learn

class HistoryWordsPresenterTests: XCTestCase {
    // swiftlint:disable implicitly_unwrapped_optional
    var view: HistoryWordsViewMock!
    var presenter: (HistoryWordsViewOutput & HistoryWordsInteractorOutput)!
    var interactor: HistoryWordsInteractorMock!
    var router: HistoryWordsRouter!
    // swiftlint:enable implicitly_unwrapped_optional

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.router = HistoryWordsRouter()
        self.interactor = HistoryWordsInteractorMock()
        let presenter = HistoryWordsPresenter(interactor: interactor, router: router)
        self.view = HistoryWordsViewMock(output: presenter)
        
        presenter.view = view
        interactor.output = presenter

        self.presenter = presenter
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
        interactor = nil
        router = nil
        
        try super.tearDownWithError()
    }

    func testViewDidReceiveModels() throws {
        view.output.viewDidLoad()
        XCTAssertNotNil(view.words, "View did not receive models from presenter")
    }
    
    func testViewDidReceiveModelsInRightOrder() throws {
        view.output.viewDidLoad()
        // swiftlint:disable:next force_unwrapping
        let wordsSections = view.words!
        XCTAssertEqual(wordsSections[0].words[0].word, "Слово2", "View did receive models in wrong order")
        XCTAssertEqual(wordsSections[1].words[0].word, "Слово1", "View did receive models in wrong order")
        XCTAssertEqual(wordsSections[2].words[0].word, "Слово4", "View did receive models in wrong order")
    }
}

final class HistoryWordsViewMock: HistoryWordsViewInput {
    let output: HistoryWordsViewOutput
    var words: [HistoryWordsSection]?
    
    init(output: HistoryWordsViewOutput) {
        self.output = output
    }
    
    func showWords(_ words: [HistoryWordsSection]) {
        self.words = words
    }
}

final class HistoryWordsInteractorMock: HistoryWordsInteractorInput {
    weak var output: HistoryWordsInteractorOutput?
    
    func fetchHistoryWords() {
        let today = Date()
        let dayInterval: Double = 60 * 60 * 24
        output?.didFetchHistoryWords([
            HistoryWord(
                word: "Слово1",
                translations: ["Перевод1", "Перевод2"],
                dateAdded: today - 2 * dayInterval,
                searchesCount: 2),
            HistoryWord(
                word: "Слово2",
                translations: ["Перевод3", "Перевод4"],
                dateAdded: today,
                searchesCount: 1),
            HistoryWord(
                word: "Слово3",
                translations: ["Перевод5", "Перевод6", "Перевод13", "Перевод14"],
                dateAdded: today - 2 * dayInterval,
                searchesCount: 1),
            HistoryWord(
                word: "Слово4",
                translations: ["Перевод7", "Перевод8"],
                dateAdded: today - 3 * dayInterval,
                searchesCount: 2),
            HistoryWord(
                word: "Слово5",
                translations: ["Перевод9", "Перевод10", "Перевод15"],
                dateAdded: today - 2 * dayInterval,
                searchesCount: 1),
            HistoryWord(
                word: "Слово6",
                translations: ["Перевод11", "Перевод12"],
                dateAdded: today - 3 * dayInterval,
                searchesCount: 3)
        ])
    }
}
