import SwiftUI
import Charts



import SwiftUI
import Charts

class ChartsMenager: ObservableObject {
    @Published var mockWeekChartData: [DailyStepModel] = []
    @Published var mockChartDataMonth: [DailyStepModel] = []
    @Published var mockChartDataThreeMonths: [MonthlyStepModel] = []
    @Published var mockChartDataYTD: [MonthlyStepModel] = []
    @Published var mockChartDataOneYear: [MonthlyStepModel] = []
    
    @Published var oneWeekAverage: Int = 0
    @Published var oneMonthAverage: Int = 0
    @Published var threeMonthsAverage: Int = 0
    @Published var ytdAverage: Int = 0
    @Published var oneYearAverage: Int = 0
    
    @Published var oneWeekTotal: Int = 0
    @Published var oneMonthTotal: Int = 0
    @Published var threeMonthsTotal: Int = 0
    @Published var ytdTotal: Int = 0
    @Published var oneYearTotal: Int = 0
    
    init() {
        fetchData(for: .oneWeek)
    }
    
    func fetchData(for option: ChartOptions) {
        switch option {
        case .oneWeek:
            mockWeekChartData = (0..<7).map {
                DailyStepModel(
                    date: Calendar.current.date(byAdding: .day, value: -$0, to: Date()) ?? Date(),
                    count: Int(Double.random(in: 8000...15000))
                )
            }
            updateTotalsAndAverages()
        
        case .oneMonth:
            mockChartDataMonth = (0..<30).map {
                DailyStepModel(
                    date: Calendar.current.date(byAdding: .day, value: -$0, to: Date()) ?? Date(),
                    count: Int(Double.random(in: 5000...20000))
                )
            }
            updateTotalsAndAverages()
        
        case .threeMonths:
            mockChartDataThreeMonths = (0..<3).map {
                MonthlyStepModel(
                    date: Calendar.current.date(byAdding: .month, value: -$0, to: Date()) ?? Date(),
                    count: Int(Double.random(in: 50000...600000))
                )
            }
            updateTotalsAndAverages()
        
        case .yearToDate:
            mockChartDataYTD = (0..<6).map {
                MonthlyStepModel(
                    date: Calendar.current.date(byAdding: .month, value: -$0, to: Date()) ?? Date(),
                    count: Int(Double.random(in: 50000...700000))
                )
            }
            updateTotalsAndAverages()
        
        case .oneYear:
            mockChartDataOneYear = (0..<12).map {
                MonthlyStepModel(
                    date: Calendar.current.date(byAdding: .month, value: -$0, to: Date()) ?? Date(),
                    count: Int(Double.random(in: 50000...800000))
                )
            }
            updateTotalsAndAverages()
        }
    }
    
    private func updateTotalsAndAverages() {
        oneWeekTotal = mockWeekChartData.reduce(0) { $0 + Int($1.count) }
        oneWeekAverage = oneWeekTotal / max(mockWeekChartData.count, 1)
        
        oneMonthTotal = mockChartDataMonth.reduce(0) { $0 + Int($1.count) }
        oneMonthAverage = oneMonthTotal / max(mockChartDataMonth.count, 1)
        
        threeMonthsTotal = mockChartDataThreeMonths.reduce(0) { $0 + Int($1.count) }
        threeMonthsAverage = threeMonthsTotal / max(mockChartDataThreeMonths.count, 1)
        
        ytdTotal = mockChartDataYTD.reduce(0) { $0 + Int($1.count) }
        ytdAverage = ytdTotal / max(mockChartDataYTD.count, 1)
        
        oneYearTotal = mockChartDataOneYear.reduce(0) { $0 + Int($1.count) }
        oneYearAverage = oneYearTotal / max(mockChartDataOneYear.count, 1)
    }
}


