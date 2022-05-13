//
//  HistoryWordsPresenter.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.04.2022.
//

import Foundation

protocol HistoryWordsViewOutput: AnyObject {
    func viewDidLoad()
    func didSelectWord(_ word: HistoryWordModel)
}

final class HistoryWordsPresenter: HistoryWordsViewOutput {
    // MARK: Dependencies
    
    weak var view: HistoryWordsViewInput?
    private let interactor: HistoryWordsInteractorProtocol
    private let router: HistoryWordsRouterProtocol
    
    // MARK: Initializer
    
    init(interactor: HistoryWordsInteractorProtocol, router: HistoryWordsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: HistoryWordsViewOutput
    
    func viewDidLoad() {
        interactor.fetchHistoryWords { [weak self] historyWords in
            let words = Dictionary(grouping: historyWords) { historyWord in
                historyWord.dateAdded.truncatingTime()
            }
                .mapValues { historyWords in
                    historyWords.map { historyWord in
                        HistoryWordModel(
                            word: historyWord.word,
                            translations: historyWord.translations.joined(separator: ", "),
                            searchesCount: historyWords.count
                        )
                    }
                }
                .sorted {
                    $0.key > $1.key
                }
                .map { date, historyWordModels in
                    HistoryWordsSection(
                        title: date.toString(using: .weekDayMonthDayFormatter),
                        words: historyWordModels
                    )
                }
            self?.view?.showWords(words)
        }
    }
    
    func didSelectWord(_ word: HistoryWordModel) {
        router.showWordDetail(WordModel(word: word.word, translations: word.translations))
    }
}
