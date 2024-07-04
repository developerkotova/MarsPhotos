//
//  FilterViewModel.swift
//  Test
//
//  Created by  Лиза Котова on 30.06.2024.
//

import Foundation

struct FilterViewModel {
    let title: String
    let imageName: String
    let type: FilterType
    
    enum FilterType {
        case camera, rover
        
        var data: [String] {
            switch self {
            case .camera:
                return Cameras.allRawValues
            case .rover:
                return Rovers.allRawValues
            }
        }
    }
}
