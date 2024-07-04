//
//  BaseRouter.swift
//  Test
//
//  Created by  Лиза Котова on 30.06.2024.
//

import UIKit
import SnapKit

class BaseRouter: RouterProtocol {
    weak var viewController: UIViewController?
    var topViewController: UIViewController? {
        return viewController
    }
    
    var parentContainerController: UIViewController? {
       if let navigationController = viewController?.navigationController {
            return navigationController
        }
        return nil
    }
    
    init() {
        onMainQueue {
            self.viewController = self.topViewController
        }
    }
    
    init(viewController: UIViewController) {
        onMainQueue {
            self.viewController = viewController
        }
    }
    
    func start(in window: UIWindow) {
        let module = LoaderModule()
        let navBar = AppNavigationController(rootViewController: module.viewController())
        navBar.navigationBar.isHidden = true 
        self.viewController = navBar
        window.rootViewController = navBar
        window.makeKeyAndVisible()
    }
    
    func replaceTopModule(with module: BaseModule, animated: Bool = true) {
        onMainQueue {
            self.viewController?.navigationController?.replaceTopViewController(
                with: module.viewController(),
                animated: animated
            )
        }
    }
    
    func openModule(_ module: BaseModule, needPinCode: Bool = false, animated: Bool = true) {
        onMainQueue {
            let controller = module.viewController()
            self.viewController?.navigationController?.pushViewController(
                controller,
                animated: animated
            )
        }
    }

    func close(animated: Bool = true, completion: Callback? = nil) {
        onMainQueue {
            if let navigationController = self.viewController?.navigationController {
                navigationController.popViewController(animated: animated)
            } else {
                self.viewController?.dismiss(animated: animated, completion: completion)
            }
        }
    }
    
    func closeToView(_ view: UIViewController? = nil, animated: Bool = true) {
        onMainQueue {
            if let view, let navigationController = self.viewController?.navigationController {
                let viewControllers = navigationController.viewControllers
                if let index = viewControllers.firstIndex(where: {
                    type(of: $0) == type(of: view)
                }) {
                    navigationController.popToViewController(viewControllers[index], animated: animated)
                }
            } else {
                self.viewController?.navigationController?.popViewController(animated: animated)
            }
        }
    }
}

//extension BaseRouter {
//    func searchTopController(for controller: UIViewController) -> UIViewController {
//        if let presentedViewController = controller.presentedViewController {
//            return searchTopController(for: presentedViewController)
//        } else if let navigationController = controller as? UINavigationController,
//                  let lastViewController = navigationController.viewControllers.last {
//            return searchTopController(for: lastViewController)
//        } else {
//            return controller
//        }
//    }
//}

