//
//  UIView+Ext.swift
//  Test
//
//  Created by  Лиза Котова on 30.06.2024.
//

import UIKit

extension UIView {
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    func add(_ view: UIView) {
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        self.addSubview(view)
        view.layer.masksToBounds = false
    }
    
    func corderRadius(
            _ radius: CGFloat = 16,
            corners: CACornerMask = .all
        ) {
            layer.maskedCorners = corners
            layer.cornerRadius = radius
            layer.masksToBounds = true
        }
    
    func addDropShadow() {
        let shadowPath = UIBezierPath(rect: self.layer.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSizeMake(0.0, -1.0)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 16
        self.layer.shadowPath = shadowPath.cgPath
    }
}

extension CACornerMask {
    static let all: CACornerMask = [
        .layerMaxXMaxYCorner,
        .layerMinXMinYCorner,
        .layerMinXMaxYCorner,
        .layerMaxXMinYCorner
    ]
    
    static let top: CACornerMask = [
        .layerMinXMinYCorner,
        .layerMaxXMinYCorner
    ]
    
    static let bottom: CACornerMask = [
        .layerMinXMaxYCorner,
        .layerMaxXMaxYCorner
    ]
    
    static let left: CACornerMask = [
        .layerMinXMinYCorner,
        .layerMinXMaxYCorner
    ]
    
    static let right: CACornerMask = [
        .layerMaxXMinYCorner,
        .layerMaxXMaxYCorner
    ]
}


