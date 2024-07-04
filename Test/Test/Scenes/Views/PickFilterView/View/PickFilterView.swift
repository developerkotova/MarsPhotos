//
//  PickFilterView.swift
//  Test
//
//  Created by  Лиза Котова on 01.07.2024.
//

import UIKit

protocol PickFilterViewDelegate: AnyObject {
    func didPickFilter(_ filter: String)
}

final class PickFilterView: UIView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var filterView: UIView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var pickerView: UIPickerView!
    private var viewModel: PickFilterViewModel!
    private var selectedRow: Int = 0
    weak var delegate: PickFilterViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        filterView.corderRadius(50, corners: .top)
    }
    
    func configure(with model: PickFilterViewModel) {
        viewModel = model
        titleLabel.text = model.title
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func show(in view: UIView) {
        self.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: self.bounds.height)
        view.addSubview(self)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = CGRect(x: 0, y: view.bounds.height - self.bounds.height, width: view.bounds.width, height: self.bounds.height)
        })
    }
}

// MARK: - Privates
private extension PickFilterView {
    
    // MARK: - Actions
    @IBAction func didTapClose(_ sender: Any) {
        hide()
    }
    @IBAction func didTapSave(_ sender: Any) {
        let selectedFilter = viewModel.dataSource[selectedRow]
        delegate?.didPickFilter(selectedFilter)
        hide()
    }
    
    // MARK: -  Methods
    func commonInit() {
        self.containerView = loadViewFromNib()
        self.add(self.containerView)
        containerView.backgroundColor = .clear
    }
    
    func hide() {
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = CGRect(x: 0, y: self.superview!.bounds.height, width: self.bounds.width, height: self.bounds.height)
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
}

// MARK: - PickerDataSource
extension PickFilterView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = viewModel.dataSource[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font: UIFont.bold(with: 22), NSAttributedString.Key.foregroundColor: UIColor.black])
        return myTitle
    }
}

// MARK: - PickerDelegate
extension PickFilterView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
}


