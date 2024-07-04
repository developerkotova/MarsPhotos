//
//  HelperFunctions.swift
//  Test
//
//  Created by  Лиза Котова on 30.06.2024.
//

import Foundation

func onMainQueue(_ block: @escaping Callback) {
    DispatchQueue.main.async(execute: block)
}

func onMainQueue(after deadline: DispatchTime, _ block: @escaping Callback) {
    DispatchQueue.main.asyncAfter(deadline: deadline, execute: block)
}

func onGlobalQueue(_ qos: DispatchQoS.QoSClass, block: @escaping Callback) {
    DispatchQueue.global(qos: qos).async(execute: block)
}

