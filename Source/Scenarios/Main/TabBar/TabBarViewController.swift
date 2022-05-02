//
//  TabBarViewController.swift
//  Find-and-Learn
//
//  Created by Роман Сницарюк on 30.04.2022.
//
import Foundation
import UIKit

final class TabBarViewController: UITabBarController {
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        setupControllers()
    }
    
    // MARK: Private
    
    private func configureAppearance() {
        tabBar.backgroundColor = R.color.defaultBackgroundColor()
        
        tabBar.tintColor = R.color.tabBarActiveIconColor()
        tabBar.barTintColor = R.color.defaultBackgroundColor()
        
        let borderView = UIView(frame: .init(
            x: 0,
            y: 0,
            width: tabBar.frame.width,
            height: .defaultBorderWidth)
        )
        borderView.backgroundColor = R.color.tabBarBorderColor()
        tabBar.addSubview(borderView)
    }
    
    private func setupControllers() {
        let viewControllers = TabBarItem.allCases.map { item -> UIViewController in
            let controller = item.asController
            controller.tabBarItem = item.asTabBarItem
            return UINavigationController(rootViewController: controller)
        }
        setViewControllers(viewControllers, animated: true)
    }
}
