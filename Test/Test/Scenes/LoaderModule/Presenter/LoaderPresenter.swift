//
//  LoaderPresenter.swift
//  Test
//
//  Created by  Лиза Котова on 30.06.2024.
//

import Foundation

protocol LoaderPresenterProtocol: AnyObject {
    func onAppear()
}

final class LoaderPresenter {
    weak var view: LoaderViewProtocol?
    private let router: LoaderRouter
    
    init(
        view: LoaderViewProtocol,
        router: LoaderRouter) {
        self.view = view
        self.router = router
    }
}

extension LoaderPresenter: LoaderPresenterProtocol {
    func onAppear() {
        onMainQueue(after: .now() + 3) { [weak self] in
            self?.router.replaceTopModule(with: HomeModule())
        }
    }
    
}


