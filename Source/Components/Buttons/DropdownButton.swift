//
//  DropdownButton.swift
//  Find-and-Learn
//
//  Created by Руслан on 29.04.2022.
//

import UIKit

protocol DropdownButtonDelegate: AnyObject {
    func addTableView(_ tableView: UITableView, height: CGFloat)
    func removeTableView(_ tableView: UITableView)
}

final class DropdownButton: UIButton {
    // MARK: UI
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self)
        tableView.separatorInset.left = .tableViewSeparatorLeftInset
        tableView.backgroundColor = R.color.defaultBackgroundColor()
        return tableView
    }()
    
    private lazy var downArrowImageView: UIImageView = {
        let imageView = UIImageView(
            image: UIImage(systemName: R.string.systemIconsNames.new_flashcard_screen_dropdown_button())
        )
        imageView.tintColor = R.color.buttonsBackgroundColor()
        return imageView
    }()
    
    // MARK: Dependencies & properties
    
    private weak var delegate: DropdownButtonDelegate?
    var dataSource: [String]? {
        didSet {
            setTextColor(R.color.textColor())
            addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            addSubview(downArrowImageView)
            downArrowImageView.snp.makeConstraints { make in
                make.width.height.equalTo(Constants.downArrowImageViewSize)
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(Constants.downArrowTrailingInset)
            }
        }
    }
    var selectedRow: Int? {
        didSet {
            guard let selectedRow = selectedRow else { return }
            let choice = dataSource?[selectedRow]
            setTitle(choice, for: .normal)
        }
    }
    
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
        
        backgroundColor = R.color.defaultBackgroundColor()
        setTitle(title, for: .normal)
        setTextColor(R.color.secondaryTextColor())
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
        guard tableView.superview == nil else {
            delegate?.removeTableView(tableView)
            return
        }
        
        if rowsCount > Constants.maxTableViewVisibleRowsCount {
            rowsCount = Constants.maxTableViewVisibleRowsCount
        }
        let tableViewHeight = CGFloat(rowsCount) * CGFloat.heightForTableViewRow
        delegate?.addTableView(tableView, height: tableViewHeight)
    }
    
    func hideDropdownList() {
        delegate?.removeTableView(tableView)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension DropdownButton: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .heightForTableViewRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
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
        cell.backgroundColor = R.color.defaultBackgroundColor()
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
