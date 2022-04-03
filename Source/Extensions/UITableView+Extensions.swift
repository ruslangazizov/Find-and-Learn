//
//  UITableView+Extensions.swift
//  Find-and-Learn
//
//  Created by Руслан on 01.04.2022.
//

import Foundation
import UIKit

extension UITableView {
    func register(_ cellTypes: UITableViewCell.Type...) {
        cellTypes.forEach { cellType in
            register(cellType.self, forCellReuseIdentifier: "\(cellType.self)")
        }
    }
    
    func dequeue<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withIdentifier: "\(cellType.self)", for: indexPath) as! T
    }
}
