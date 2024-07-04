//
//  CalendarView.swift
//  Test
//
//  Created by  Лиза Котова on 30.06.2024.
//


import UIKit

protocol CalendarViewDelegate: AnyObject {
    func didSelectDate(_ date: Date)
}

final class CalendarView: UIView {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var blurView: UIView!
    @IBOutlet private weak var calendarView: UIView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var datePicker: UIDatePicker!
    private var date: Date?
    weak var delegate: CalendarViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calendarView.corderRadius(50, corners: .all)
        calendarView.layer.masksToBounds = true
    }
    
    func setDate(_ date: Date) {
        self.date = date
        datePicker.setDate(date, animated: true)
    }
}

// MARK: - Privates
private extension CalendarView {
    
    // MARK: - Actions
    @IBAction private func didTapClose(_ sender: Any) {
        removeFromSuperview()
    }
    
    @IBAction private func didTapSave(_ sender: Any) {
        delegate?.didSelectDate(datePicker.date)
        removeFromSuperview()
    }
    
    // MARK: - Methods
    func commonInit() {
        self.containerView = loadViewFromNib()
        self.add(self.containerView)
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "en_US")
        datePicker.date = date ?? Date()
    }
    
    func setupUI() {
        blurView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
}
