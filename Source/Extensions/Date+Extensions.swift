//
//  Date+Extensions.swift
//  Find-and-Learn
//
//  Created by Руслан on 05.04.2022.
//

import Foundation

extension Date {
    func toString(using formatter: DateFormatter) -> String {
        return formatter.string(from: self)
    }
    
    func truncatingTime() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: self)
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        // swiftlint:disable:next force_unwrapping
        return formatter.date(from: dateString + " 00:00:00")!
    }
}
