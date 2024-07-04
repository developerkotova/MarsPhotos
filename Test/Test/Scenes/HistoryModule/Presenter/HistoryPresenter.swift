//
//  HistoryPresenter.swift
//  Test
//
//  Created by  Лиза Котова on 01.07.2024.
//

import Foundation

protocol HistoryPresenterProtocol: AnyObject {
    func onAppear()
    func onBackAction()
}

final class HistoryPresenter {
    weak var view: HistoryViewProtocol?
    private let router: HistoryRouter
    
    init(
        view: HistoryViewProtocol,
        router: HistoryRouter) {
        self.view = view
        self.router = router
    }
}

extension HistoryPresenter: HistoryPresenterProtocol {
    
    func onBackAction() {
        router.close()
    }
    
    func onAppear() {
        }
}
