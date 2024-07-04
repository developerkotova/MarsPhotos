//
//  HistoryModule.swift
//  Test
//
//  Created by  Лиза Котова on 01.07.2024.
//

import UIKit

final class HistoryModule {

    private let view: HistoryViewController
    
    init() {
        view = HistoryViewController()
        let router = HistoryRouter()
        router.viewController = view
        let presenter = HistoryPresenter(
            view: view,
            router: router)
        view.presenter = presenter
    }
}

extension HistoryModule: BaseModule {
    func viewController() -> UIViewController {
        return view
    }
}
