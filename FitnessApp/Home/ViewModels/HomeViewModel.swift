import SwiftUI

class HomeViewModel: ObservableObject {
    let healthManager = HealthManager.shared
    
    @Published var calories: Int = 0
    @Published var active: Int = 0
    @Published var stand: Int = 0
    
    @Published var mockActivities = [
        Activity(id: 0, title: "Number", subtitle: "Steps taken", image: "figure.walk", titntColor: .green, amount: "12,432"),
        Activity(id: 1, title: "Calories", subtitle: "Calories burned", image: "flame", titntColor: .red, amount: "9876"),
        Activity(id: 2, title: "Distance", subtitle: "Distance covered", image: "map", titntColor: .blue, amount: "5.2 km"),
        Activity(id: 3, title: "Steps", subtitle: "Total steps", image: "figure.walk", titntColor: .orange, amount: "10,212")
    ]
    
    @Published var mockWorkouts = [
        Workout(id: 0, title: "Running", image: "figure.run", tintcolor: .red, duration: "31 min", date: "March 20", calories: "360 kcal"),
        Workout(id: 1, title: "Cycling", image: "bicycle", tintcolor: .blue, duration: "45 min", date: "March 22", calories: "500 kcal"),
        Workout(id: 2, title: "Swimming", image: "figure.pool.swim", tintcolor: .green, duration: "25 min", date: "March 25", calories: "320 kcal"),
        Workout(id: 3, title: "Yoga", image: "figure.yoga", tintcolor: .purple, duration: "60 min", date: "March 27", calories: "150 kcal"),
        Workout(id: 4, title: "Strength Training", image: "dumbbell", tintcolor: .orange, duration: "50 min", date: "March 28", calories: "420 kcal")
    ]
    
    init() {
        Task {
            do {
                try await healthManager.requestHealthKitAccess()
                // Fetch data after authorization
                self.fetchTodayCalories()
                self.fetchTodayExerciseTime()
                self.fetchTodayStandHours()
            } catch {
                print("HealthKit access failed: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchTodayCalories() {
        healthManager.fetchTodayCaloriesBurned { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    self.calories = Int(value) // Integer value, e.g., 123
                    print("Calories: \(value)")
                case .failure(let error):
                    self.calories = 0 // Fallback integer value
                    print("Calories error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchTodayExerciseTime() {
        healthManager.fetchTodayExerciseTime { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    self.active = Int(value) // Integer value, e.g., 45
                    print("Exercise time: \(value)")
                case .failure(let error):
                    self.active = 0 // Fallback integer value
                    print("Exercise error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchTodayStandHours() {
        healthManager.fetchTodayStandHours { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    self.stand = value // Direct Int assignment, e.g., 5
                    print("Stand hours: \(value)")
                case .failure(let error):
                    self.stand = 0 // Fallback integer value
                    print("Stand hours error: \(error.localizedDescription)")
                }
            }
        }
    }
}
