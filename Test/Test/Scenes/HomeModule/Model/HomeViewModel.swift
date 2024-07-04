//
//  HomeViewModel.swift
//  Test
//
//  Created by  Лиза Котова on 30.06.2024.
//

import Foundation

struct HomeViewModel {
    let title: String
    let subtitle: String
    let systemFilter: FilterViewModel
    let cameraFilter: FilterViewModel
}

struct RoverItem: Hashable {
    let id = UUID().uuidString
    let rover: String
    let camera: String
    let date: String
    let image: String
}
