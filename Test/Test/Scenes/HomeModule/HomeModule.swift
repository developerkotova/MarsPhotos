//
//  HomeModule.swift
//  Test
//
//  Created by  Лиза Котова on 30.06.2024.
//

import UIKit

final class HomeModule {

    private let view: HomeViewController
    
    init() {
        view = HomeViewController()
        let router = HomeRouter()
        router.viewController = view
        let presenter = HomePresenter(
            view: view,
            router: router, 
            networkService: NetworkService())
        view.presenter = presenter
    }
}

extension HomeModule: BaseModule {
    func viewController() -> UIViewController {
        return view
    }
}
