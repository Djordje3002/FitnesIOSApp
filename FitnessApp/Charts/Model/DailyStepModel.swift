//
//  DailyStepModel.swift
//  FitnessApp
//
//  Created by Djordje Mitrovic on 2.4.25..
//

import Foundation

struct DailyStepModel: Identifiable {
    let id = UUID()
    let date: Date
    let count: Int
}
