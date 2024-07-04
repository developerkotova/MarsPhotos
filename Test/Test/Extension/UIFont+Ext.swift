//
//  UIFont+Ext.swift
//  Test
//
//  Created by  Лиза Котова on 01.07.2024.
//
import UIKit

extension UIFont {
    static func bold(with size: CGFloat) -> UIFont {
        return UIFont(name: "SF Pro Display Bold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func regular(with size: CGFloat) -> UIFont {
        return UIFont(name: "SF Pro Display Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func medium(with size: CGFloat) -> UIFont {
        return UIFont(name: "SF Pro Display Medium", size: size) ?? .systemFont(ofSize: size)
    }
}
