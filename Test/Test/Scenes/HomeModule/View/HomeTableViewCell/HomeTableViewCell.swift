//
//  HomeTableViewCell.swift
//  Test
//
//  Created by  Лиза Котова on 01.07.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class HomeTableViewCell: UITableViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.corderRadius(30, corners: .all)
        return view
    }()
    private let photoImage: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.corderRadius(20, corners: .all)
        return view
    }()
    private let filterLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(with: 22)
        label.numberOfLines = 0
        label.textColor = UIColor(named: "MainOrange")
        return label
    }()
    private let roverLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(with: 16)
        label.numberOfLines = 0
        return label
    }()
    private let cameraLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(with: 16)
        label.numberOfLines = 0
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(with: 16)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        containerView.addDropShadow()
    }

    func configurCell(with model: HomeTableViewModel) {
        roverLabel.text = model.rover
        cameraLabel.text = model.camera
        dateLabel.text = model.date
        let url = URL(string: model.image)
        photoImage.kf.setImage(
            with: url,
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25)),
            ]
        )
    }
}

// MARK: - Privates
private extension HomeTableViewCell {
    func setupUI() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.contentView.addSubview(containerView)
        self.contentView.layer.masksToBounds = false
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(12)
        }
        self.containerView.addSubview(photoImage)
        photoImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(130)
            make.top.greaterThanOrEqualToSuperview().offset(10)
            make.bottom.greaterThanOrEqualToSuperview().inset(10)
        }
        self.containerView.addSubview(roverLabel)
        roverLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(photoImage.snp.leading).inset(-10)
        }
        self.containerView.addSubview(cameraLabel)
        cameraLabel.snp.makeConstraints { make in
            make.top.equalTo(roverLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(photoImage.snp.leading).inset(-10)
        }
        self.containerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(cameraLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(photoImage.snp.leading).inset(-10)
            make.bottom.equalToSuperview().inset(27)
        }
    }
}
