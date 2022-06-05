//
//  RouterProtocol.swift
//  Find-and-Learn
//
//  Created by Руслан on 31.03.2022.
//

import Foundation
import UIKit

// TODO: (r.akhmadeev) Для чего нужно? наверное можно убрать
protocol RouterProtocol: AnyObject {
    var view: UIViewController? { get set }
}
