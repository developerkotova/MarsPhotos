//
//  HistoryTableViewCell.swift
//  Test
//
//  Created by  Лиза Котова on 01.07.2024.
//

import UIKit
import SnapKit

final class HistoryTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.corderRadius(30, corners: .all)
        return view
    }()
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "MainOrange")
        view.layer.shadowColor = UIColor.black.cgColor
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
    
    func configurCell(with model: HistoryTableViewModel) {
        filterLabel.text = model.filter
        roverLabel.text = model.rover
        cameraLabel.text = model.camera
        dateLabel.text = model.date
    }
}

// MARK: - Privates
private extension HistoryTableViewCell {
    func setupUI() {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(12)
        }
        self.containerView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(1)
            make.width.equalTo(251)
        }
        self.containerView.addSubview(filterLabel)
        filterLabel.snp.makeConstraints { make in
            make.centerY.equalTo(lineView.snp.centerY)
            make.leading.equalTo(lineView.snp.trailing).offset(6)
            make.trailing.equalToSuperview().inset(16)
        }
        self.containerView.addSubview(roverLabel)
        roverLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(12)
        }
        self.containerView.addSubview(cameraLabel)
        cameraLabel.snp.makeConstraints { make in
            make.top.equalTo(roverLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(12)
        }
        self.containerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(cameraLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
