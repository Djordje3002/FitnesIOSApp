import SwiftUI
import Charts

struct ChartsView: View {
    @StateObject var healthManager = HealthManagerNew()
    @State var selectedChart: ChartOptions = .oneWeek
    
    var body: some View {
        VStack {
            Text("Charts")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            ChartDataView(
                average: averageForSelectedChart(),
                total: totalForSelectedChart()
            )
            
            ZStack {
                if selectedChart == .oneWeek || selectedChart == .oneMonth {
                    let dailyData: [DailyStepModel] = selectedChart == .oneWeek ? healthManager.mockWeekChartData : healthManager.mockChartDataMonth
                    if !dailyData.isEmpty {
                        Chart(dailyData) { data in
                            BarMark(
                                x: .value("Date", data.date, unit: .day),
                                y: .value("Steps", data.count)
                            )
                            .foregroundStyle(.green)
                        }
                        .chartXAxis {
                            AxisMarks(values: .stride(by: .day)) { value in
                                AxisValueLabel(format: .dateTime.day().month())
                            }
                        }
                        .frame(height: 300)
                    }
                } else {
                    let monthlyData: [MonthlyStepModel] = {
                        switch selectedChart {
                        case .threeMonths: return healthManager.mockChartDataThreeMonths
                        case .yearToDate: return healthManager.mockChartDataYTD
                        case .oneYear: return healthManager.mockChartDataOneYear
                        default: return []
                        }
                    }()
                    if !monthlyData.isEmpty {
                        Chart(monthlyData) { data in
                            BarMark(
                                x: .value("Date", data.date, unit: .month),
                                y: .value("Steps", data.count)
                            )
                            .foregroundStyle(.green)
                        }
                        .chartXAxis {
                            AxisMarks(values: .stride(by: .month)) { value in
                                AxisValueLabel(format: .dateTime.month().year())
                            }
                        }
                        .frame(height: 300)
                    }
                }
            }
            
            HStack {
                ForEach(ChartOptions.allCases, id: \.rawValue) { option in
                    Button(option.rawValue) {
                        withAnimation {
                            selectedChart = option
                            healthManager.fetchData(for: option)
                        }
                    }
                    .padding()
                    .foregroundColor(selectedChart == option ? .white : .green)
                    .background(selectedChart == option ? .green : .clear)
                    .cornerRadius(10)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear {
            healthManager.fetchData(for: .oneWeek) // Set initial values
        }
    }
    
    private func averageForSelectedChart() -> Int {
        switch selectedChart {
        case .oneWeek: return healthManager.oneWeekAverage
        case .oneMonth: return healthManager.oneMonthAverage
        case .threeMonths: return healthManager.threeMonthsAverage
        case .yearToDate: return healthManager.ytdAverage
        case .oneYear: return healthManager.oneYearAverage
        }
    }
    
    private func totalForSelectedChart() -> Int {
        switch selectedChart {
        case .oneWeek: return healthManager.oneWeekTotal
        case .oneMonth: return healthManager.oneMonthTotal
        case .threeMonths: return healthManager.threeMonthsTotal
        case .yearToDate: return healthManager.ytdTotal
        case .oneYear: return healthManager.oneYearTotal
        }
    }
}

#Preview {
    ChartsView()
}
