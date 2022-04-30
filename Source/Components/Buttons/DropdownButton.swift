//
//  DropdownButton.swift
//  Find-and-Learn
//
//  Created by Руслан on 29.04.2022.
//

import UIKit

protocol DropdownButtonDelegate: AnyObject {
    func addOrRemoveTableView(_ tableView: UITableView, height: CGFloat)
    func removeTableView(_ tableView: UITableView)
}

final class DropdownButton: UIButton {
    // MARK: UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self)
        tableView.separatorInset.left = .tableViewSeparatorLeftInset
        return tableView
    }()
    
    private lazy var downArrowImageView = UIImageView(image: UIImage(
        systemName: R.string.systemIconsNames.new_flashcard_screen_dropdown_button()
    ))
    
    // MARK: Dependencies & properties
    
    private weak var delegate: DropdownButtonDelegate?
    var dataSource: [String]? {
        didSet {
            setTitleColor(.black, for: .normal)
            addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            addSubview(downArrowImageView)
            downArrowImageView.snp.makeConstraints { make in
                make.width.height.equalTo(Constants.downArrowImageViewSize)
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(Constants.downArrowTrailingInset)
            }
        }
    }
    var selectedRow: Int?
    
    // MARK: Initializers
    
    init(
        title: String,
        borderColor: CGColor,
        cornerRadius: CGFloat,
        borderWidth: CGFloat,
        delegate: DropdownButtonDelegate?,
        dataSource: [String]? = nil
    ) {
        super.init(frame: .zero)
        self.delegate = delegate
        self.dataSource = dataSource
        
        setTitle(title, for: .normal)
        setTitleColor(.lightGray, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .callout)
        layer.borderColor = borderColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        tableView.layer.borderColor = borderColor
        tableView.layer.cornerRadius = cornerRadius
        tableView.layer.borderWidth = borderWidth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc private func didTapButton() {
        guard var rowsCount = dataSource?.count else { return }
        if rowsCount > Constants.maxTableViewVisibleRowsCount {
            rowsCount = Constants.maxTableViewVisibleRowsCount
        }
        let tableViewHeight = CGFloat(rowsCount) * CGFloat.heightForTableViewRow
        delegate?.addOrRemoveTableView(tableView, height: tableViewHeight)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension DropdownButton: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .heightForTableViewRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataSource = dataSource else { return }
        
        selectedRow = indexPath.row
        let choice = dataSource[indexPath.row]
        setTitle(choice, for: .normal)
        delegate?.removeTableView(tableView)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(UITableViewCell.self, for: indexPath)
        cell.textLabel?.text = dataSource?[indexPath.row]
        cell.textLabel?.font = .preferredFont(forTextStyle: .callout)
        return cell
    }
}

// MARK: - Constants

private enum Constants {
    static let downArrowImageViewSize = 20
    static let downArrowTrailingInset = 8
    
    static let maxTableViewVisibleRowsCount = 5
}

private extension CGFloat {
    static let tableViewSeparatorLeftInset: CGFloat = 0
    static let heightForTableViewRow: CGFloat = 50
}
