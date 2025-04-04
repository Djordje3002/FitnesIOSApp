import Foundation
import HealthKit

extension Date {
    static var startOfDay: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: Date())
    }
}

class HealthManager {
    static let shared = HealthManager()
    let healthStore = HKHealthStore()
    
    private init() {
        let calories = HKQuantityType(.activeEnergyBurned)
        let exercise = HKQuantityType(.appleExerciseTime)
        let stand = HKCategoryType(.appleStandHour)
        let steps = HKQuantityType(.stepCount)
        let distance = HKQuantityType(.distanceWalkingRunning)
        let workouts = HKObjectType.workoutType() // Added workouts
        
        let healthTypes: Set = [calories, exercise, stand, steps, distance, workouts]
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                print("HealthKit authorization granted")
            } catch {
                print("Authorization failed: \(error.localizedDescription)")
            }
        }
    }
    
    func requestHealthKitAccess() async throws {
        let calories = HKQuantityType(.activeEnergyBurned)
        let exercise = HKQuantityType(.appleExerciseTime)
        let stand = HKCategoryType(.appleStandHour)
        let steps = HKQuantityType(.stepCount)
        let distance = HKQuantityType(.distanceWalkingRunning)
        let workouts = HKObjectType.workoutType()
        let healthTypes: Set = [calories, exercise, stand, steps, distance, workouts]
        
        try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
    }
    
    func fetchTodayCaloriesBurned(completion: @escaping (Result<Double, Error>) -> Void) {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            if let error = error { completion(.failure(error)); return }
            guard let quantity = result?.sumQuantity() else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No calorie data"])))
                return
            }
            completion(.success(quantity.doubleValue(for: HKUnit.kilocalorie())))
        }
        healthStore.execute(query)
    }
    
    func fetchTodayExerciseTime(completion: @escaping (Result<Double, Error>) -> Void) {
        let exercise = HKQuantityType(.appleExerciseTime)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: exercise, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            if let error = error { completion(.failure(error)); return }
            guard let quantity = result?.sumQuantity() else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No exercise data"])))
                return
            }
            completion(.success(quantity.doubleValue(for: HKUnit.minute())))
        }
        healthStore.execute(query)
    }
    
    func fetchTodayStandHours(completion: @escaping (Result<Int, Error>) -> Void) {
        let stand = HKCategoryType(.appleStandHour)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKSampleQuery(sampleType: stand, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, samples, error in
            if let error = error { completion(.failure(error)); return }
            guard let standSamples = samples as? [HKCategorySample] else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No stand data"])))
                return
            }
            let standHours = standSamples.filter { $0.value == HKCategoryValueAppleStandHour.stood.rawValue }.count
            completion(.success(standHours))
        }
        healthStore.execute(query)
    }
    
    func fetchTodaySteps(completion: @escaping (Result<Int, Error>) -> Void) {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            if let error = error { completion(.failure(error)); return }
            guard let quantity = result?.sumQuantity() else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No step data"])))
                return
            }
            completion(.success(Int(quantity.doubleValue(for: HKUnit.count()))))
        }
        healthStore.execute(query)
    }
    
    func fetchTodayDistance(completion: @escaping (Result<Double, Error>) -> Void) {
        let distance = HKQuantityType(.distanceWalkingRunning)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: distance, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            if let error = error { completion(.failure(error)); return }
            guard let quantity = result?.sumQuantity() else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No distance data"])))
                return
            }
            completion(.success(quantity.doubleValue(for: HKUnit.meter()) / 1000))
        }
        healthStore.execute(query)
    }
    
    func fetchRecentWorkouts(completion: @escaping (Result<[HKWorkout], Error>) -> Void) {
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, end: Date())
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: .workoutType(), predicate: predicate, limit: 5, sortDescriptors: [sortDescriptor]) { _, samples, error in
            if let error = error { completion(.failure(error)); return }
            guard let workouts = samples as? [HKWorkout] else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No workout data"])))
                return
            }
            completion(.success(workouts))
        }
        healthStore.execute(query)
    }
}
