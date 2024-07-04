//
//  FilterView.swift
//  Test
//
//  Created by  Лиза Котова on 30.06.2024.
//

import UIKit

final class FilterView: UIView {
    
    @IBOutlet private weak var filterImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
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
        self.corderRadius(10, corners: .all)
        self.layer.masksToBounds = true
    }
    
    func configure(with model: FilterViewModel) {
        filterImage.image = UIImage(named: model.imageName)
        titleLabel.text = model.title
    }
    
    func updateTitle(with title: String) {
        titleLabel.text = title
    }
}

private extension FilterView {
    func commonInit() {
        let nib = UINib(nibName: "FilterView", bundle: nil)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = bounds
            addSubview(view)
        }
    }
}
