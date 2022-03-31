//
//  ScreenAssemblyProtocol.swift
//  Find-and-Learn
//
//  Created by Руслан on 31.03.2022.
//

import Foundation
import UIKit

protocol ScreenAssemblyProtocol: AnyObject {
    static func assemble(with router: RouterProtocol) -> UIViewController
}
