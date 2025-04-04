//
//  ChartsViewModel.swift
//  FitnessApp
//
//  Created by Djordje Mitrovic on 2.4.25..
//

import Foundation

class ChartsViewModel: ObservableObject {
    var mockWeekChartData: [DailyStepModel] = (0..<7).map {
        DailyStepModel(
            date: Calendar.current.date(byAdding: .day, value: -$0, to: Date()) ?? Date(),
            count: Int.random(in: 8000...15000)
        )
    }
    
    var mockChartDataMonth: [DailyStepModel] = (0..<30).map {
        DailyStepModel(
            date: Calendar.current.date(byAdding: .day, value: -$0, to: Date()) ?? Date(),
            count: Int.random(in: 5000...20000)
        )
    }
    
    var mockChartDataThreeMonths: [MonthlyStepModel] = (0..<3).map {
        MonthlyStepModel(
            date: Calendar.current.date(byAdding: .month, value: -$0, to: Date()) ?? Date(),
            count: Int.random(in: 150000...450000)
        )
    }
    
    var mockChartDataOneYear: [MonthlyStepModel] = (0..<12).map {
        MonthlyStepModel(
            date: Calendar.current.date(byAdding: .month, value: -$0, to: Date()) ?? Date(),
            count: Int.random(in: 150000...600000)
        )
    }
    
    var mockChartDataYTD: [MonthlyStepModel] {
        let startOfYear = Calendar.current.date(from: Calendar.current.dateComponents([.year], from: Date())) ?? Date()
        let monthsSinceStart = Calendar.current.dateComponents([.month], from: startOfYear, to: Date()).month ?? 0
        return (0...monthsSinceStart).map {
            MonthlyStepModel(
                date: Calendar.current.date(byAdding: .month, value: -$0, to: Date()) ?? Date(),
                count: Int.random(in: 150000...600000)
            )
        }
    }
    
    @Published var oneWeekAverage = 1123
    @Published var oneWeekTotal = 12321
    
    @Published var oneMonthAverage = 234
    @Published var oneMonthTotal = 6543
    
    @Published var threeMonthsAverage = 234
    @Published var threeMonthsTotal = 76543
    
    @Published var ytdAverage = 654
    @Published var ytdTotal = 234
    
    @Published var oneYearAverage = 3435
    @Published var oneYearTotal = 34556765
}

