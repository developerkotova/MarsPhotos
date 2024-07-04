//
//  BaseModule.swift
//  Test
//
//  Created by  Лиза Котова on 30.06.2024.
//

import UIKit

protocol BaseModule {
    func viewController() -> UIViewController
}

protocol BaseViewModule {
    associatedtype ViewType: UIView
    func customView() -> ViewType
}

