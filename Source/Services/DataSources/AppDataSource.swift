//
//  AppDataSource.swift
//  Find-and-Learn
//
//  Created by Руслан on 20.03.2022.
//

import Foundation

protocol AppDataSourceProtocol: AnyObject {
    var isInitialAppOpening: Bool { get }
}

final class AppDataSource: AppDataSourceProtocol {
    var isInitialAppOpening: Bool {
        return true
    }
}
