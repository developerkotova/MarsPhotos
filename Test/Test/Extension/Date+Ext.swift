//
//  Date+Ext.swift
//  Test
//
//  Created by  Лиза Котова on 02.07.2024.
//

import Foundation

extension Date {
    func toString(format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        
        switch format {
        case .short:
            dateFormatter.dateFormat = "yyyy-MM-dd"
        case .long:
            dateFormatter.dateFormat = "MMMM d, yyyy"
        }
        
        return dateFormatter.string(from: self)
    }
    
    enum DateFormat {
        case short
        case long
    }
}
