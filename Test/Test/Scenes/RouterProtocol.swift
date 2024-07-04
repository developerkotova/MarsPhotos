//
//  RouterProtocol.swift
//  Test
//
//  Created by  Лиза Котова on 30.06.2024.
//

import UIKit

protocol RouterProtocol: AnyObject {
    var viewController: UIViewController? { get }
    var topViewController: UIViewController? { get }
    var parentContainerController: UIViewController? { get }
    func openModule(_ module: BaseModule, needPinCode: Bool, animated: Bool)
    func close(animated: Bool, completion: Callback?)
    func closeToView(_ view: UIViewController?, animated: Bool)
    func replaceTopModule(with module: BaseModule, animated: Bool)
    func start(in window: UIWindow)
}

