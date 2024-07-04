//
//  LoaderViewController.swift
//  Test
//
//  Created by  Лиза Котова on 30.06.2024.
//

import UIKit
import SnapKit
import Lottie

protocol LoaderViewProtocol: AnyObject {
    
}

final class LoaderViewController: UIViewController {
    
    private let boxView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "MainOrange")
        view.corderRadius(30, corners: .all)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let animationView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.backgroundColor = .clear
        view.animation = LottieAnimation.named("LoaderTest")
        return view
    }()
    
    var presenter: LoaderPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        boxView.addDropShadow()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAnimation()
        presenter.onAppear()
    }
    
}

// MARK: - Privates
private extension LoaderViewController {
    func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(boxView)
        boxView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.15)
            make.width.equalTo(boxView.snp.height)
            make.center.equalToSuperview()
        }
        self.view.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.24)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupAnimation() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
    }
}

extension LoaderViewController: LoaderViewProtocol {}
