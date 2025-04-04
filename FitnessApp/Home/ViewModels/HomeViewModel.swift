import SwiftUI

class HomeViewModel: ObservableObject {
    let healthManager = HealthManager.shared
    
    @Published var calories: Int = 0
    @Published var active: Int = 0
    @Published var stand: Int = 0
    @Published var steps: Int = 0
    @Published var distance: Double = 0.0
    
    @Published var activities: [Activity] = []
    @Published var workouts: [Workout] = []
    
    init() {
        Task {
            do {
                try await healthManager.requestHealthKitAccess()
                fetchAllData()
            } catch {
                print("HealthKit access failed: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchAllData() {
        fetchTodayCalories()
        fetchTodayExerciseTime()
        fetchTodayStandHours()
        fetchTodaySteps()
        fetchTodayDistance()
        fetchRecentWorkouts()
    }
    
    func fetchTodayCalories() {
        healthManager.fetchTodayCaloriesBurned { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    self.calories = Int(value)
                    self.updateActivities()
                    print("Calories: \(value)")
                case .failure(let error):
                    self.calories = 0
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
                    self.active = Int(value)
                    print("Exercise time: \(value)")
                case .failure(let error):
                    self.active = 0
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
                    self.stand = value
                    print("Stand hours: \(value)")
                case .failure(let error):
                    self.stand = 0
                    print("Stand hours error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchTodaySteps() {
        healthManager.fetchTodaySteps { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    self.steps = value
                    self.updateActivities()
                    print("Steps: \(value)")
                case .failure(let error):
                    self.steps = 0
                    print("Steps error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchTodayDistance() {
        healthManager.fetchTodayDistance { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    self.distance = value
                    self.updateActivities()
                    print("Distance: \(value) km")
                case .failure(let error):
                    self.distance = 0
                    print("Distance error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchRecentWorkouts() {
        healthManager.fetchRecentWorkouts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let hkWorkouts):
                    self.workouts = hkWorkouts.enumerated().map { (index, workout) in
                        let title = workout.workoutActivityType.name
                        let image = workout.workoutActivityType.icon
                        let tintColor = workout.workoutActivityType.color
                        let duration = Int(workout.duration / 60) // Convert seconds to minutes
                        let date = DateFormatter.localizedString(from: workout.startDate, dateStyle: .medium, timeStyle: .none)
                        let calories = Int(workout.totalEnergyBurned?.doubleValue(for: .kilocalorie()) ?? 0)
                        return Workout(id: index, title: title, image: image, tintcolor: tintColor, duration: "\(duration) min", date: date, calories: "\(calories) kcal")
                    }
                    print("Workouts fetched: \(self.workouts.count)")
                case .failure(let error):
                    self.workouts = []
                    print("Workouts error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func updateActivities() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        
        activities = [
            Activity(id: 0, title: "Steps", subtitle: "Steps taken", image: "figure.walk", titntColor: .green, amount: formatter.string(from: NSNumber(value: steps)) ?? "0"),
            Activity(id: 1, title: "Calories", subtitle: "Calories burned", image: "flame", titntColor: .red, amount: "\(calories) kcal"),
            Activity(id: 2, title: "Distance", subtitle: "Distance covered", image: "map", titntColor: .blue, amount: String(format: "%.1f km", distance))
        ]
    }
}

