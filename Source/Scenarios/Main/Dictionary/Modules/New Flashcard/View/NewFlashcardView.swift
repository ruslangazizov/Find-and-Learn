//
//  NewFlashcardView.swift
//  Find-and-Learn
//
//  Created by Руслан on 30.04.2022.
//

import UIKit

final class NewFlashcardView: UIView {
    // MARK: UI
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = .fieldStackViewSpacing
        return stackView
    }()
    
    lazy var frontSideTextView = FieldTextView(
        borderColor: .fieldBorderColor,
        cornerRadius: .fieldCornerRadius,
        borderWidth: .fieldBorderWidth
    )
    
    lazy var frontSideStackView = FieldStackView(
        titleView: UILabel(R.string.localizable.new_flashcard_screen_front_side_label_text()),
        fieldView: frontSideTextView,
        spacing: .innerStackViewSpacing
    )
    
    lazy var backSideTextView = FieldTextView(
        borderColor: .fieldBorderColor,
        cornerRadius: .fieldCornerRadius,
        borderWidth: .fieldBorderWidth
    )
    
    lazy var backSideStackView = FieldStackView(
        titleView: UILabel(R.string.localizable.new_flashcard_screen_back_side_label_text()),
        fieldView: backSideTextView,
        spacing: .innerStackViewSpacing
    )
    
    lazy var deckChoiceButton = DropdownButton(
        title: R.string.localizable.new_flashcard_screen_dropdown_button_text(),
        borderColor: .fieldBorderColor,
        cornerRadius: .fieldCornerRadius,
        borderWidth: .fieldBorderWidth,
        delegate: self
    )
    
    lazy var deckChoiceStackView = FieldStackView(
        titleView: UILabel(R.string.localizable.new_flashcard_screen_deck_choice_label_text()),
        fieldView: deckChoiceButton,
        spacing: .innerStackViewSpacing
    )
    
    lazy var commentTextView = FieldTextView(
        borderColor: .fieldBorderColor,
        cornerRadius: .fieldCornerRadius,
        borderWidth: .fieldBorderWidth
    )
    
    lazy var commentInfoButton: UIButton = {
        let button = UIButton()
        let imageSystemName = R.string.systemIconsNames.new_flashcard_screen_info_button()
        button.setImage(UIImage(systemName: imageSystemName), for: .normal)
        button.addTarget(delegate, action: #selector(delegate?.didTapCommentInfoButton), for: .touchUpInside)
        return button
    }()
    
    lazy var commentStackView: FieldStackView = {
        let label = UILabel(R.string.localizable.new_flashcard_screen_comment_label_text())
        let stackView = UIStackView(arrangedSubviews: [label, commentInfoButton, UIView()])
        stackView.spacing = .stackViewWithInfoButtonSpacing
        return FieldStackView(
            titleView: stackView,
            fieldView: commentTextView,
            spacing: .innerStackViewSpacing
        )
    }()
    
    lazy var checkboxButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = .checkboxBorderWidth
        button.layer.borderColor = .checkboxBorderColor
        button.layer.backgroundColor = .checkboxPassiveColor
        button.addTarget(delegate, action: #selector(delegate?.didTapCheckboxButton), for: .touchUpInside)
        return button
    }()
    
    lazy var createReversedFlashcardInfoButton: UIButton = {
        let button = UIButton()
        let imageSystemName = R.string.systemIconsNames.new_flashcard_screen_info_button()
        button.setImage(UIImage(systemName: imageSystemName), for: .normal)
        button.addTarget(
            delegate,
            action: #selector(delegate?.didTapCreateReversedFlashcardInfoButton),
            for: .touchUpInside
        )
        return button
    }()
    
    lazy var createReversedFlashcardStackView: UIStackView = {
        let label = UILabel(R.string.localizable.new_flashcard_screen_create_reversed_flashcard_label_text())
        let dummyView = UIView()  // it will fill the trailing gap in stack view
        let stackView = UIStackView(arrangedSubviews: [
            checkboxButton, label, createReversedFlashcardInfoButton, dummyView
        ])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = .stackViewWithInfoButtonSpacing
        return stackView
    }()
    
    private weak var delegate: NewFlashcardViewController?
    
    // MARK: Init
    
    init(delegate: NewFlashcardViewController) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        addGestureRecognizer(UITapGestureRecognizer(target: delegate, action: #selector(delegate.hideKeyboard)))
        
        configureTextViewDelegates()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI configuration
    
    private func configureTextViewDelegates() {
        [frontSideTextView, backSideTextView, commentTextView].forEach {
            $0.delegate = delegate
        }
    }
    
    private func configureLayout() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.topInset)
            make.leading.trailing.equalTo(self).inset(Constants.sidesInsets)
            make.bottom.equalToSuperview()
        }
        
        stackView.addArrangedSubviews([
            frontSideStackView,
            backSideStackView,
            deckChoiceStackView,
            commentStackView,
            createReversedFlashcardStackView
        ])
        
        checkboxButton.snp.makeConstraints { make in
            make.width.height.equalTo(Constants.checkboxSize)
        }
    }
}

extension NewFlashcardView: DropdownButtonDelegate {
    func addOrRemoveTableView(_ tableView: UITableView, height: CGFloat) {
        guard tableView.superview == nil else {
            removeTableView(tableView)
            return
        }
        
        addSubview(tableView)
        gestureRecognizers?.forEach { $0.isEnabled = false }
        tableView.alpha = 0
        tableView.snp.makeConstraints { make in
            make.top.equalTo(deckChoiceButton.snp.bottom)
            make.width.centerX.equalTo(deckChoiceButton)
            make.height.equalTo(height)
        }
        UIView.animate(withDuration: .tableViewAppearanceDuration) {
            tableView.alpha = 1
        }
    }
    
    func removeTableView(_ tableView: UITableView) {
        UIView.animate(withDuration: .tableViewAppearanceDuration, delay: 0, options: .curveEaseInOut) {
            tableView.alpha = 0
        } completion: { _ in
            tableView.removeFromSuperview()
            self.gestureRecognizers?.forEach { $0.isEnabled = true }
        }
    }
}

// MARK: - Constants

private enum Constants {
    static let topInset = 15
    static let sidesInsets = 25
    
    static let checkboxSize = 18
}

private extension CGFloat {
    static let fieldStackViewSpacing: CGFloat = 12
    static let stackViewWithInfoButtonSpacing: CGFloat = 8
    static let innerStackViewSpacing: CGFloat = 6
    
    static let fieldCornerRadius: CGFloat = 10
    
    static let fieldBorderWidth: CGFloat = 1
    static let checkboxBorderWidth: CGFloat = 1
}

private extension CGColor {
    static let fieldBorderColor: CGColor = UIColor.lightGray.cgColor
    static let checkboxBorderColor: CGColor = UIColor.lightGray.cgColor
    
    static let checkboxPassiveColor: CGColor = UIColor.white.cgColor
}

private extension TimeInterval {
    static let tableViewAppearanceDuration: TimeInterval = 0.3
}
