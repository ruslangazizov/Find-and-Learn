//
//  HistoryWordsUnitTests.swift
//  Find-and-Learn-Tests
//
//  Created by Руслан on 03.04.2022.
//

import XCTest
@testable import Find_and_Learn

class HistoryWordsInteractorTests: XCTestCase {
    // swiftlint:disable implicitly_unwrapped_optional
    var view: HistoryWordsViewController!
    var presenter: HistoryWordsPresenterMock!
    var interactor: HistoryWordsInteractorInput!
    var router: HistoryWordsRouter!
    var dataManager: DataManagerMock!
    // swiftlint:enable implicitly_unwrapped_optional

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.router = HistoryWordsRouter()
        self.dataManager = DataManagerMock()
        let interactor = HistoryWordsInteractor(dataManager: dataManager)
        self.presenter = HistoryWordsPresenterMock(interactor: interactor, router: router)
        self.view = HistoryWordsViewController(output: presenter)
        
        presenter.view = view
        router.view = view
        interactor.output = presenter

        self.interactor = interactor
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
        interactor = nil
        router = nil
        dataManager = nil
        
        try super.tearDownWithError()
    }

    func testHistoryWordsFetching() throws {
        interactor.fetchHistoryWords()
        XCTAssertNotNil(presenter.fetchedHistoryWords, "Presenter did not receive fetched models from interactor")
        // swiftlint:disable:next force_unwrapping
        XCTAssert(!presenter.fetchedHistoryWords!.isEmpty, "Presenter received zero fetched models from interactor")
    }
}

final class HistoryWordsPresenterMock: HistoryWordsViewOutput & HistoryWordsInteractorOutput {
    private let interactor: HistoryWordsInteractorInput
    private let router: RouterProtocol
    weak var view: HistoryWordsViewInput?
    
    var fetchedHistoryWords: [HistoryWord]?
    
    init(interactor: HistoryWordsInteractorInput, router: RouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
    }
    
    func didSelectWord(_ word: HistoryWordModel) {
    }
    
    func didFetchHistoryWords(_ historyWords: [HistoryWord]) {
        self.fetchedHistoryWords = historyWords
    }
}
