//
//  DateFormatter+EEEEMMMd.swift
//  Find-and-Learn
//
//  Created by Руслан on 03.04.2022.
//

import Foundation

extension DateFormatter {
    static let EEEEMMMd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter
    }()
}
