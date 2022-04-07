//
//  HistoryWordsPresenter.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.04.2022.
//

import Foundation

final class HistoryWordsPresenter {
    // MARK: Dependencies
    
    weak var view: HistoryWordsViewInput?
    private let interactor: HistoryWordsInteractorProtocol
    private let router: HistoryWordsRouterProtocol
    
    // MARK: Initializer
    
    init(interactor: HistoryWordsInteractorProtocol, router: HistoryWordsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - HistoryWordsViewOutput

extension HistoryWordsPresenter: HistoryWordsViewOutput {
    func viewDidLoad() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.interactor.fetchHistoryWords { [weak self] historyWords in
                var dateToWords: [Date: [HistoryWordModel]] = [:]
                historyWords.forEach { historyWord in
                    let historyWordModel = HistoryWordModel(
                        word: historyWord.word,
                        translations: historyWord.translations.joined(separator: ", "),
                        searchesCount: historyWord.searchesCount)
                    dateToWords[historyWord.dateAdded.truncatingTime(), default: []].append(historyWordModel)
                }
                var words: [HistoryWordsSection] = []
                dateToWords.sorted { $0.key > $1.key }.forEach { date, historyWordModels in
                    words.append(HistoryWordsSection(
                        title: date.toString(using: .weekDayMonthDayFormatter),
                        words: historyWordModels
                    ))
                }
                DispatchQueue.main.async {
                    self?.view?.showWords(words)
                }
            }
        }
    }
    
    func didSelectWord(_ word: HistoryWordModel) {
        router.showWordDetail(word.word)
    }
}