//
//  Find_and_Learn_Tests.swift
//  Find-and-Learn-Tests
//
//  Created by Руслан on 03.04.2022.
//

import XCTest
@testable import Find_and_Learn

final class HistoryWordsIntegrationTests: XCTestCase {
    // swiftlint:disable implicitly_unwrapped_optional
    var view: HistoryWordsViewInput!
    weak var presenter: (HistoryWordsViewOutput & HistoryWordsInteractorOutput)!
    weak var interactor: HistoryWordsInteractorInput!
    weak var router: HistoryWordsRouterProtocol!
    weak var dataManager: DataManagerProtocol!
    // swiftlint:enable implicitly_unwrapped_optional

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let router = HistoryWordsRouter()
        let dataManager = DataManagerMock()
        let interactor = HistoryWordsInteractor(dataManager: dataManager)
        let presenter = HistoryWordsPresenter(interactor: interactor, router: router)
        let view = HistoryWordsViewController(output: presenter)
        
        presenter.view = view
        router.view = view
        interactor.output = presenter

        self.view = view
        self.presenter = presenter
        self.interactor = interactor
        self.router = router
        self.dataManager = dataManager
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
        interactor = nil
        router = nil
        dataManager = nil
        
        try super.tearDownWithError()
    }

    func testNoMemoryLeak() throws {
        view = nil
        XCTAssertNil(presenter, "Presenter must be deinitialized after deinitializing view")
        XCTAssertNil(interactor, "Interactor must be deinitialized after deinitializing view and presenter")
        XCTAssertNil(router, "Router must be deinitialized after deinitializing view")
        XCTAssertNil(dataManager, "DataManager must be deinitialized after deinitializing view")
    }
}
