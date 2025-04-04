//
//  HKWorkoutActivityType.swift
//  FitnessApp
//
//  Created by Djordje Mitrovic on 4.4.25..
//

import Foundation
import HealthKit
import SwiftUICore

extension HKWorkoutActivityType {
    var name: String {
        switch self {
        case .running: return "Running"
        case .cycling: return "Cycling"
        case .swimming: return "Swimming"
        case .yoga: return "Yoga"
        case .traditionalStrengthTraining: return "Strength Training"
        default: return "Workout"
        }
    }
    
    var icon: String {
        switch self {
        case .running: return "figure.run"
        case .cycling: return "bicycle"
        case .swimming: return "figure.pool.swim"
        case .yoga: return "figure.yoga"
        case .traditionalStrengthTraining: return "dumbbell"
        default: return "figure.walk"
        }
    }
    
    var color: Color {
        switch self {
        case .running: return .red
        case .cycling: return .blue
        case .swimming: return .green
        case .yoga: return .purple
        case .traditionalStrengthTraining: return .orange
        default: return .gray
        }
    }
}
