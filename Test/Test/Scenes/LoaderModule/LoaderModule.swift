//
//  LoaderModule.swift
//  Test
//
//  Created by  Лиза Котова on 30.06.2024.
//

import UIKit

final class LoaderModule {

    private let view: LoaderViewController
    
    init() {
        view = LoaderViewController()
        let router = LoaderRouter()
        router.viewController = view
        let presenter = LoaderPresenter(
            view: view,
            router: router)
        view.presenter = presenter
    }
}

extension LoaderModule: BaseModule {
    func viewController() -> UIViewController {
        return view
    }
}
