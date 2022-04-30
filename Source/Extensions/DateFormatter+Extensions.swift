//
//  DateFormatter+Extensions.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.04.2022.
//

import Foundation

extension DateFormatter {
    static let weekDayMonthDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter
    }()
    
    static let commonDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d.M.yyyy"
        return formatter
    }()
}
