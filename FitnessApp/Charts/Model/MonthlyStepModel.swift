//
//  MonthlyStepModel.swift
//  FitnessApp
//
//  Created by Djordje Mitrovic on 2.4.25..
//

import Foundation

struct MonthlyStepModel: Identifiable {
    let id = UUID()
    let date: Date
    let count: Int
}
