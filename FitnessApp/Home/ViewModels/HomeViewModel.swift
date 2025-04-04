import SwiftUI

class HomeViewModel: ObservableObject {
    
//    let healthManager = HealthManagerNew()
    
    @Published var calories: Int = 100
    @Published var active: Int = 55
    @Published var stand: Int = 320
    
    @Published var mockActivities = [
        Activity(id: 0, title: "Number", subtitle: "Steps taken", image: "figure.walk", titntColor: .green, amount: "12,432"),
        Activity(id: 1, title: "Calories", subtitle: "Calories burned", image: "flame", titntColor: .red, amount: "9876"),
        Activity(id: 2, title: "Distance", subtitle: "Distance covered", image: "map", titntColor: .blue, amount: "5.2 km"),
        Activity(id: 3, title: "Steps", subtitle: "Total steps", image: "figure.walk", titntColor: .orange, amount: "10,212")
    ]
    
    @Published var MockWorkouts = [
        Workout(id: 0, title: "Running", image: "figure.run", tintcolor: .red, duration: "31 min", date: "March 20", calories: "360 kcal"),
        Workout(id: 1, title: "Cycling", image: "bicycle", tintcolor: .blue, duration: "45 min", date: "March 22", calories: "500 kcal"),
        Workout(id: 2, title: "Swimming", image: "figure.pool.swim", tintcolor: .green, duration: "25 min", date: "March 25", calories: "320 kcal"),
        Workout(id: 3, title: "Yoga", image: "figure.yoga", tintcolor: .purple, duration: "60 min", date: "March 27", calories: "150 kcal"),
        Workout(id: 4, title: "Strength Training", image: "dumbbell", tintcolor: .orange, duration: "50 min", date: "March 28", calories: "420 kcal")
    ]
}

