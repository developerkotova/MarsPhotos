//
//  AppNavigationController.swift
//  Test
//
//  Created by  Лиза Котова on 30.06.2024.
//

import UIKit

final class AppNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

private extension AppNavigationController {
    func setupUI() {
        if #available(iOS 15.0, *) {
            navigationBar.isTranslucent = true
            navigationBar.barTintColor = .clear
            navigationBar.backItem?.title = ""
            navigationItem.setHidesBackButton(true, animated: false)
        } else {
            navigationBar.isTranslucent = true
            navigationBar.barTintColor = self.view.backgroundColor
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.backItem?.title = ""
            navigationItem.setHidesBackButton(true, animated: false)
        }
    }
}

